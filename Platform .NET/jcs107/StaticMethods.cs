namespace jcs107;

public static class StaticMethods
{
    public static string UpperAfterSpace(this string text)
    {
        string[] list = text.Split(" ");

        for (int i = 0; i < list.Length; i++)
        {
            list[i] = char.ToUpper(list[i][0]) + list[i].Substring(1);
        }

        return string.Join(" ", list);
    }


    public static DateTime WhenTimesFactor(DateTime son, DateTime father, int factor)
    {
        if (factor < 1)
        {
            throw new ArgumentException("Factor musí být větší než 1");
        }

        if (son <= father)
        {
            throw new ArgumentException("Otec musí být starší než syn");
        }

        return new DateTime((factor * son.Ticks - father.Ticks) / (factor - 1));
    }
}
