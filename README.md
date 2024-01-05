# DanioVision
Scripts for DanioVision Behavioural Analysis

1) Compatibility of DanioVision data with FramebyFrame package

Example Script 1 Conversion DanioVision to ZebraBox 

The activity values obtained from the DanioVision raw files are the "Percentage of Pixel Changed" between the current and the previous frame. All pixels are taken into account but the setting of a prior threshold (here 20) allows to measure zebrafish larvae-specific motion. The Activity is hence calculated as changed pixels (CP) divided by the total number of pixels per well (TP) times 100 to get a percentage. 

The Zebrabox Data uses delta pixel as it basic unit of data. For the conversion the CP need to be multiplied by TP/100. In our case for a 96-well arena this equals to 82.8075 pixels. 

The Script described removes extra header lines that are obtained from the raw files of the DanioVision data and then loops over the 96 larvae files that are all named similarly and only differ by the number of the larvae/well. The columns for activity and time (sec) are being extracted. Activity is converted to delta pixel and the columns are newly printed. They are then sorted first by time and secondly by fish ID, before they are split into million rows per file. 
