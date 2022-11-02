FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY . .
#拷贝字体
COPY /wwwroot/Captcha/Font/zkkht.ttf /usr/share/fonts/zkkht.ttf
#安装libgdiplus 
RUN apt-get update -y && apt-get install -y libgdiplus && apt-get clean && ln -s /usr/lib/libgdiplus.so /usr/lib/gdiplus.dll
ENTRYPOINT ["dotnet", "Magic.Web.Entry.dll"]