
Write-Host "Клавиша $ - установка времени, клавиша Q - выход."
$port= new-Object System.IO.Ports.SerialPort COM5,9600,None,8,one
$port.Open()
$HOST.UI.RawUI.Flushinputbuffer()

while ($port.IsOpen) {
    $line = $port.ReadLine()
    Write-Host $line
    if ($host.ui.RawUi.KeyAvailable) {
        $key = $host.ui.RawUi.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")
        if ($key.Character -eq 'q') { break; }
        elseif ( $key.Character -eq '$') {
            $port.Write($key.Character)
            $dt = ([DateTimeOffset](Get-Date)).ToUnixTimeSeconds()
            $dt += 5 * 60 * 60 + 2
            $port.Write($dt)
        }
    }
}
$port.Close()

