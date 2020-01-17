..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zilf.exe -w werner3.zil
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe -ab werner3.zap > werner3_freq.xzap
del werner3_freq.zap
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe werner3.zap
del /F /Q ..\..\bin\*.*
del /F /Q ..\..\zapf\*.*
move *.zap ..\..\zapf\
move *.xzap ..\..\zapf\
move *.dbg ..\..\zapf\
move *.z5 ..\..\bin\
