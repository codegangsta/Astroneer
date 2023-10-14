
using Mutagen.Bethesda;
using Mutagen.Bethesda.Environments;
using Mutagen.Bethesda.Plugins;
using Mutagen.Bethesda.Starfield;
using Noggog;

using var env = GameEnvironment.Typical.Starfield();

var inputPath = @"D:\SteamLibrary\steamapps\common\Starfield\Data\Starfield.esm";
var outputPath = @"D:\SteamLibrary\steamapps\common\Starfield\Data\Astroneer.esp";

using var starfieldMaster = StarfieldMod.CreateFromBinaryOverlay(inputPath);

var astroneer = new StarfieldMod(ModKey.FromNameAndExtension(Path.GetFileName(outputPath)));

if(starfieldMaster.TerminalMenus.TryGetValue(FormKey.Factory("227D8F:Starfield.esm"), out var originalMenu))
{
    Console.WriteLine("Terminal menu found! Overriding...");
    var menu = astroneer.TerminalMenus.GetOrAddAsOverride(originalMenu);
    menu.Name = "Astroneer Terminal Menu";

    var item = new TerminalMenuItem();
    item.ItemText = "Stock Market";
    item.DisplayText = "This is where you will be able to access stock market data";
    menu.MenuItems.Add(item);

    // loop 10 times
    for(int i = 0; i < 10; i++)
    {
        var item2 = new TerminalMenuItem();
        item2.ItemText = $"Item {i}";
        item2.ItemShortText = $"Item {i} (short)";
        item2.DisplayText = $"This is item {i}";
        menu.MenuItems.Add(item2);
    }
}
else
{
    Console.WriteLine("Terminal menu not found");
}

astroneer.WriteToBinaryParallel(outputPath);
Console.WriteLine("Done!");
