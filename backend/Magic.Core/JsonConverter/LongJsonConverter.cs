using System;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Magic.Core;

/// <summary>
/// Long 类型Json返回处理
/// </summary>
public class LongJsonConverter : JsonConverter<long>
{
    /// <summary>Reads and converts the JSON to type <typeparamref name="T" />.</summary>
    /// <param name="reader">The reader.</param>
    /// <param name="typeToConvert">The type to convert.</param>
    /// <param name="options">An object that specifies serialization options to use.</param>
    /// <returns>The converted value.</returns>
    public override long Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
    {
        // 这里做处理，前端传入的Long类型可能为String类型，或者Number类型。
        return reader.TokenType == JsonTokenType.String ? long.Parse(reader.GetString()) : reader.GetInt64();
    }

    /// <summary>Writes a specified value as JSON.</summary>
    /// <param name="writer">The writer to write to.</param>
    /// <param name="value">The value to convert to JSON.</param>
    /// <param name="options">An object that specifies serialization options to use.</param>
    public override void Write(Utf8JsonWriter writer, long value, JsonSerializerOptions options)
    {
        writer.WriteStringValue($"{value}");
    }
}
