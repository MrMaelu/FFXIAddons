# Modded XIVBAR by MrMaelu
### NOTE: This version is heavily modified compared to the original.

## New features:
1. Dynamic job and weapon icons.
2. More flexible settings available to make theme creation easier.
3. Possibility for 3 TP bars.
4. Bars can be placed anywhere.
5. Includes other themes than the original from SirEdeonX. I have not ported the existing themes to the new layout, so I removed them from this release.
6. Includes a theme selector application to allow for easier swapping between themes.
7. Supports an Elden Ring like death message. Only enabled for the EldenRing theme by default.

## Theme selector
https://user-images.githubusercontent.com/12958339/228619252-bd97cb6a-1218-4866-974a-855fbeb141fd.mp4

## Elden Ring death message
![dead](https://user-images.githubusercontent.com/12958339/228691947-9935ef19-462a-4abd-807b-77e30d64d7a2.png)


## Removed features:
1. Compact mode
2. SirEdeonX themes

----------------------------------------------------------------------------------------

# xivbar
This addon displays vital bars for easy tracking

## Available Settings (needs update)
##### Bars
* **Offset X** - moves the entire addon left (negative number) or right (positive number) the given number of pixels
* **Offset Y** - moves the entire addon up (negative number) or down (positive number) the given number of pixels

##### Theme
* **Name** - Name of the theme to use
* **Compact** - Enables or disables compact mode (obsolete)
* **Bar** - Values for bar width, spacing, offset and compact mode. Useful for creating a custom theme. 

##### Texts
* **Color** - The font color for the HP, MP and TP numbers
* **Font** - The font for the HP, MP and TP numbers
* **Offset** - moves the HP, MP and TP numbers left (negative number) or right (positive number) the given number of pixels
* **Size** - The font size for the HP, MP and TP numbers
* **Stroke** - The font stroke the HP, MP and TP numbers
* **FullTpColor** - The font color for the TP numbers when the bar is full
* **DimTpBar** - dim the TP bar when not full

## How to edit the settings
1. Login to your character in FFXI
2. Edit the addon's settings file: **_Windower4\addons\xivbar\data\settings.xml_**
3. Save the file 
4. Press Insert in FFXI to access the windower console 
5. Type ``` lua r xivbar ``` to reload the addon
6. Press Insert in FFXI again to close the windower console

## How to create my own custom theme
1. Create a folder inside the *theme* directory of the addon: **_Windower4\addons\xivbar\themes\MY_CUSTOM_THEME_**
2. Create the necessary images. A theme is usually composed of 7 images: a background and foreground for the bars (*bar_bg.png / bar_fg.png*), and one image for each bar (*hp_fg.png, mp_fg.png, tp1_fg.png, tp2_fg.png, tp3_fg.png*). You can take a look at the default themes. For jobicon and weaponicon functions you will need 22 + 12 images as well, if used. Detection of ranged weapons is currently not supported.
3. Create the theme specific settings file in the theme folder. Copy settings.xml from the data folder to start. Name it *settings_THEMENAME.xml*
4. Adjust settings in the new file according to your needs.
5. Copy the theme specific settings to **_Windower4\addons\xivbar\data\ThemeSelectorResources_**
