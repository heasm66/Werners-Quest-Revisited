..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zilf.exe -w werner2.zil
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe -ab werner2.zap > werner2_freq.xzap
del werner2_freq.zap
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe werner2.zap
del /F /Q ..\..\bin\*.*
del /F /Q ..\..\zapf\*.*
move *.zap ..\..\zapf\
move *.xzap ..\..\zapf\
move *.dbg ..\..\zapf\
move *.z5 ..\..\bin\
