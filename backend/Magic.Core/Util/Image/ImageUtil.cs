using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Furion.RemoteRequest.Extensions;

namespace Magic.Core;

/// <summary>
/// 图片工具类
/// </summary>
public static class ImageUtil
{
    /// <summary>
    /// 获取外网Url图片的二进制数组
    /// </summary>
    /// <param name="url"></param>
    /// <returns></returns>
    public static async Task<byte[]> GetBytesFromUrl(this string url)
    {
        // 得到图片流
        var result = await url.GetAsStreamAsync();
        using var binaryReader = new BinaryReader(result.Stream);
        // 读取二进制文件流
        var resultBytes = binaryReader.ReadBytes(result.Stream.Length.ParseToInt());
        binaryReader.Close();

        return resultBytes;
    }

    /// <summary>
    /// 保存二进制流到文件
    /// </summary>
    /// <param name="content"></param>
    /// <param name="fileName"></param>
    public static async Task WriteBytesToFile(byte[] content, string fileName)
    {
        // 检测文件夹是否存在
        if (!Directory.Exists(fileName[..fileName.LastIndexOf("/", StringComparison.Ordinal)]))
        {
            Directory.CreateDirectory(fileName[..fileName.LastIndexOf("/", StringComparison.Ordinal)]);
        }

        // 检测文件是否存在
        if (!File.Exists(fileName))
        {
            await File.WriteAllBytesAsync(fileName, content);
        }
    }

    /// <summary>
    /// 保存外网Url到文件
    /// </summary>
    /// <param name="url">外网图片Url</param>
    /// <param name="fileName">要保存的文件名称</param>
    /// <returns></returns>
    public static async Task SaveFromUrlToFile(this string url, string fileName)
    {
        var bytes = await url.GetBytesFromUrl();
        await WriteBytesToFile(bytes, fileName);
    }

    /// <summary>
    /// 删除文件夹里面所有的文件
    /// </summary>
    /// <param name="fileName"></param>
    /// <returns></returns>
    public static void DeleteFile(this string fileName)
    {
        foreach (var entry in Directory.GetFileSystemEntries(fileName))
        {
            if (!File.Exists(entry))
                continue;
            var name = Path.GetFileNameWithoutExtension(entry);
            File.Delete(entry);
        }
    }

    /// <summary>
    /// 无损压缩图片
    /// </summary>
    /// <param name="sourceFile">原图片地址</param>
    /// <param name="compressFile">压缩后保存图片地址</param>
    /// <param name="compressHeight">压缩后宽度</param>
    /// <param name="compressWidth">压缩后高度</param>
    /// <param name="flag">压缩质量（数字越小压缩率越高）</param>
    /// <param name="size">压缩后图片的最大大小</param>
    /// <param name="isFirst">是否为第一次调用</param>
    /// <returns></returns>
    public static bool CompressImage(string sourceFile, string compressFile, int compressHeight = 750,
        int compressWidth = 1334, int flag = 90, int size = 110, bool isFirst = true)
    {
        // 如果是第一次调用，原始图像的大小小于要压缩的大小，则直接复制文件，并且返回True
        var firstFileInfo = new FileInfo(sourceFile);
        if (isFirst && firstFileInfo.Length < size * 1024)
        {
            firstFileInfo.CopyTo(compressFile);
            return true;
        }

        var imageSource = Image.FromFile(sourceFile);
        var imageFormat = imageSource.RawFormat;
        var sourceWidth = 0;
        var sourceHeight = 0;

        // 按比例缩放
        var temSize = new Size(imageSource.Width, imageSource.Height);

        // 处理大小，如果是0，原大小
        if (compressHeight.IsNullOrZero())
        {
            compressHeight = temSize.Height;
        }

        if (compressWidth.IsNullOrZero())
        {
            compressWidth = temSize.Width;
        }

        if (temSize.Width > compressHeight || temSize.Width > compressWidth)
        {
            if ((temSize.Width * compressHeight) > (temSize.Width * compressWidth))
            {
                sourceWidth = compressWidth;
                sourceHeight = (compressWidth * temSize.Height) / temSize.Width;
            }
            else
            {
                sourceWidth = compressHeight;
                sourceHeight = (temSize.Height * compressHeight) / temSize.Height;
            }
        }
        else
        {
            sourceWidth = temSize.Width;
            sourceHeight = temSize.Height;
        }


        var bitmap = new Bitmap(compressWidth, compressHeight);

        var graphics = Graphics.FromImage(bitmap);
        graphics.Clear(Color.Transparent);
        graphics.CompositingQuality = CompositingQuality.HighQuality;
        graphics.SmoothingMode = SmoothingMode.HighQuality;
        graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
        graphics.DrawImage(imageSource,
            new Rectangle((compressWidth - sourceWidth) / 2, (compressHeight - sourceHeight) / 2, sourceWidth, sourceHeight),
            0, 0, imageSource.Width, imageSource.Height, GraphicsUnit.Pixel);
        graphics.Dispose();

        // 设置压缩质量
        var encoderParameters =
            new EncoderParameters {Param = {[0] = new EncoderParameter(Encoder.Quality, new long[] {flag})}};

        try
        {
            // 找到系统中可用的图片编码器信息
            var imageCodecInfos = ImageCodecInfo.GetImageEncoders();
            var jpegIciInfo = imageCodecInfos.FirstOrDefault(t => t.FormatDescription.Equals("JPEG"));

            // 如果编码器存在的，可以压缩
            if (jpegIciInfo != null)
            {
                bitmap.Save(compressFile, jpegIciInfo, encoderParameters);
                var fileInfo = new FileInfo(compressFile);
                if (fileInfo.Length <= 1024 * size)
                    return true;
                flag -= 10;
                CompressImage(sourceFile, compressFile, compressHeight, compressWidth, flag, size, false);
            }
            else
            {
                bitmap.Save(compressFile, imageFormat);
            }

            return true;
        }
        catch
        {
            return false;
        }
        finally
        {
            imageSource.Dispose();
            bitmap.Dispose();
        }
    }
}
