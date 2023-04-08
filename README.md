# Modded XIVBAR by MrMaelu
### NOTE: This version is heavily modified compared to the original by SirEdeonX.

## New features:
1. Dynamic job and weapon icons.
2. More flexible settings available to make theme creation easier.
3. Possibility for 3 TP bars.
4. Bars can be placed anywhere.
5. Includes other themes than the original from SirEdeonX. I have not ported the existing themes to the new layout, so I removed them from this release.
6. Includes a theme selector application to allow for easier swapping between themes.
7. Supports an Elden Ring like death message. Only enabled for the EldenRing theme by default.

## Added themes:
![Themes](https://user-images.githubusercontent.com/12958339/229646627-c00329bc-5138-4a9b-8091-5f89c01759b0.png)

## Theme selector
https://user-images.githubusercontent.com/12958339/228619252-bd97cb6a-1218-4866-974a-855fbeb141fd.mp4

## Elden Ring death message
https://user-images.githubusercontent.com/12958339/228695809-7abfd144-df69-4a56-92d3-357560656710.mp4
#### This is also available as a separate addon.

## Removed features:
1. Compact mode
2. SirEdeonX themes

### In-game console options:
* "xivbar theme <themename>" will change theme, if the requested theme exists.
* "xivbar pos <number> <number>" will place the bar at the specified position.
* "xivbar x <number>" will move the bar right with positive and left with negative numbers.
* "xivbar y <number>" will move the bar down with positive and up with negative numbers.
* "xivbar center" will center the bar on your screen
* "xivbar scale <number>" will resize the bar by the percentage given, relative to it's default size.
* "xivbar reset" will reset the current theme to it's default settings and reload the addon.
* "xivbar save" will save the settings to the theme settings file.

If you do not save the settings will be returned to their defaults when you change themes.

## Available Settings
#### Bars
* **Offset X** - moves the entire addon left (negative number) or right (positive number) the given number of pixels
* **Offset Y** - moves the entire addon up (negative number) or down (positive number) the given number of pixels

#### Theme
* **Name** - Name of the theme to use
* **Compact** - Enables or disables compact mode (obsolete)
* **DimTpBar** - dim the TP bar when not full
* **bgalpha / fgalpha** - sets the transparency for the background and foreground
* **jobiconalpha / weaponiconalpha** - sets the transparency for the job icon and weapon icon. Can set to 0 if you do not want them.
  ##### Bar
    * alphamin - Sets the transparency for the bars while below 100%
    * alphamax - Sets the transparency for the bars while at 100%
  

#### Texts
* **Color** - The font color for the HP, MP and TP numbers
* **Font** - The font for the HP, MP and TP numbers
* **Offset** - moves the HP, MP and TP numbers left (negative number) or right (positive number) the given number of pixels
* **Size** - The font size for the HP, MP and TP numbers
* **Stroke** - The font stroke the HP, MP and TP numbers
* **FullTpColor** - The font color for the TP numbers when the bar is full
* **prefix** - Enables or disables the HP/MP/TP prefix for the numbers


## How to edit the settings
The easiest way is to use the in-game console commands.
Alternatively do it manually:
1. Login to your character in FFXI
2. Edit the addon's settings file: **_xivbar\data\settings.xml_**
3. Save the file
4. Press Insert in FFXI to access the windower console 
5. Type ``` lua r xivbar ``` to reload the addon
6. Press Insert in FFXI again to close the windower console

## How to create my own custom theme
Take a look at the included themes for some reference.
1. Create a folder inside the *theme* directory of the addon: **_Windower4\addons\xivbar\themes\MY_CUSTOM_THEME_**
2. Create the necessary images. A theme is usually composed of 7 images:
  * A background (**_bar_bg.png_**)
  * A forground (**_bar_fg.png_**)
  * One image for each bar (**_hp_fg.png, mp_fg.png, tp1_fg.png, tp2_fg.png, tp3_fg.png_**).
  * Optional: job icons and weapon icons 22 + 12 images. (**_1.png to 22.png and 1w.png to 12w.png_**)
  * Note: Detection of ranged weapons is currently not supported.
3. Create the theme specific settings file in the theme folder. Copy settings.xml from the data folder to start. Name it *settings_THEMENAME.xml*
4. Adjust settings in the new file according to your needs.
5. Copy the theme specific settings to **_Windower4\addons\xivbar\data\ThemeSelectorResources_**


# YouDied
Adds an Elden Ring like "you died" message on screen when you die.
That's all.

![deadcrop](https://user-images.githubusercontent.com/12958339/230463861-25c98fca-e302-4a33-9a5c-581c236aecb4.png)
