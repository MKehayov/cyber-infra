#Windows
!228 ar.conf
restart-ossec0 - restart-ossec.sh - 0
restart-ossec0 - restart-ossec.cmd - 0
restart-wazuh0 - restart-ossec.sh - 0
restart-wazuh0 - restart-ossec.cmd - 0
restart-wazuh0 - restart-wazuh - 0
restart-wazuh0 - restart-wazuh.exe - 0
!9451 agent.conf
  <agent_config>
    <client_buffer>
      <!-- Agent buffer options -->
      <disabled>no</disabled>
      <queue_size>5000</queue_size>
      <events_per_second>500</events_per_second>
    </client_buffer>
    <!-- Policy monitoring -->
    <rootcheck>
      <disabled>no</disabled>
      <windows_apps>./shared/win_applications_rcl.txt</windows_apps>
      <windows_malware>./shared/win_malware_rcl.txt</windows_malware>
    </rootcheck>
    <sca>
      <enabled>yes</enabled>
      <scan_on_start>yes</scan_on_start>
      <interval>12h</interval>
      <skip_nfs>yes</skip_nfs>
    </sca>
    <!-- File integrity monitoring -->
    <syscheck>
      <disabled>no</disabled>
      <!-- Frequency that syscheck is executed default every 12 hours -->
      <frequency>43200</frequency>
      <!-- Default files to be monitored. -->
      <directories recursion_level="0" restrict="regedit.exe$|system.ini$|win.ini$">%WINDIR%</directories>
      <directories recursion_level="0" restrict="at.exe$|attrib.exe$|cacls.exe$|cmd.exe$|eventcreate.exe$|ftp.exe$|lsass.exe$|net.exe$|net1.exe$|netsh.exe$|reg.exe$|regedt32.exe|regsvr32.exe|runas.exe|sc.exe|schtasks.exe|sethc.exe|subst.exe$">%WINDIR%\SysNative</directories>
      <directories recursion_level="0">%WINDIR%\SysNative\drivers\etc</directories>
      <directories recursion_level="0" restrict="WMIC.exe$">%WINDIR%\SysNative\wbem</directories>
      <directories recursion_level="0" restrict="powershell.exe$">%WINDIR%\SysNative\WindowsPowerShell\v1.0</directories>
      <directories recursion_level="0" restrict="winrm.vbs$">%WINDIR%\SysNative</directories>
      <!-- 32-bit programs. -->
      <directories recursion_level="0" restrict="at.exe$|attrib.exe$|cacls.exe$|cmd.exe$|eventcreate.exe$|ftp.exe$|lsass.exe$|net.exe$|net1.exe$|netsh.exe$|reg.exe$|regedit.exe$|regedt32.exe$|regsvr32.exe$|runas.exe$|sc.exe$|schtasks.exe$|sethc.exe$|subst.exe$">%WINDIR%\System32</directories>
      <directories recursion_level="0">%WINDIR%\System32\drivers\etc</directories>
      <directories recursion_level="0" restrict="WMIC.exe$">%WINDIR%\System32\wbem</directories>
      <directories recursion_level="0" restrict="powershell.exe$">%WINDIR%\System32\WindowsPowerShell\v1.0</directories>
      <directories recursion_level="0" restrict="winrm.vbs$">%WINDIR%\System32</directories>
      <directories realtime="yes">%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup</directories>
      <ignore>%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\desktop.ini</ignore>
      <ignore type="sregex">.log$|.htm$|.jpg$|.png$|.chm$|.pnf$|.evtx$</ignore>
      <!-- Windows registry entries to monitor. -->
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\batfile</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\cmdfile</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\comfile</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\exefile</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\piffile</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\AllFilesystemObjects</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\Directory</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Classes\Folder</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Classes\Protocols</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Policies</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Security</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\KnownDLLs</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\winreg</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce</windows_registry>
      <windows_registry>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnceEx</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\URL</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Windows</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon</windows_registry>
      <windows_registry arch="both">HKEY_LOCAL_MACHINE\Software\Microsoft\Active Setup\Installed Components</windows_registry>
      <!-- Windows registry entries to ignore. -->
      <registry_ignore>HKEY_LOCAL_MACHINE\Security\Policy\Secrets</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\Security\SAM\Domains\Account\Users</registry_ignore>
      <registry_ignore type="sregex">\Enum$</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\AppCs</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\PortKeywords\DHCP</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\PortKeywords\IPTLSIn</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\PortKeywords\IPTLSOut</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\PortKeywords\RPC-EPMap</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MpsSvc\Parameters\PortKeywords\Teredo</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\PolicyAgent\Parameters\Cache</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnceEx</registry_ignore>
      <registry_ignore>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ADOVMPPackage\Final</registry_ignore>
      <!-- Frequency for ACL checking (seconds) -->
      <windows_audit_interval>60</windows_audit_interval>
      <!-- Nice value for Syscheck module -->
      <process_priority>10</process_priority>
      <!-- Maximum output throughput -->
      <max_eps>100</max_eps>
      <!-- Database synchronization settings -->
      <synchronization>
        <enabled>yes</enabled>
        <interval>5m</interval>
        <max_interval>1h</max_interval>
        <max_eps>10</max_eps>
      </synchronization>
    </syscheck>
    <!-- System inventory -->
    <wodle name="syscollector">
      <disabled>no</disabled>
      <interval>1h</interval>
      <scan_on_start>yes</scan_on_start>
      <hardware>yes</hardware>
      <os>yes</os>
      <network>yes</network>
      <packages>yes</packages>
      <ports all="no">yes</ports>
      <processes>yes</processes>
      <!-- Database synchronization settings -->
      <synchronization>
        <max_eps>10</max_eps>
      </synchronization>
    </wodle>
    <!-- CIS policies evaluation -->
    <wodle name="cis-cat">
      <disabled>yes</disabled>
      <timeout>1800</timeout>
      <interval>1d</interval>
      <scan-on-start>yes</scan-on-start>
      <java_path>\\server\jre\bin\java.exe</java_path>
      <ciscat_path>C:\cis-cat</ciscat_path>
    </wodle>
    <!-- Osquery integration -->
    <wodle name="osquery">
      <disabled>yes</disabled>
      <run_daemon>yes</run_daemon>
      <bin_path>C:\Program Files\osquery\osqueryd</bin_path>
      <log_path>C:\Program Files\osquery\log\osqueryd.results.log</log_path>
      <config_path>C:\Program Files\osquery\osquery.conf</config_path>
      <add_labels>yes</add_labels>
    </wodle>
    <!-- Active response -->
    <active-response>
      <disabled>no</disabled>
      <ca_store>wpk_root.pem</ca_store>
      <ca_verification>yes</ca_verification>
    </active-response>
    <!-- Log analysis -->
    <localfile>
      <location>Microsoft-Windows-Sysmon/Operational</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Windows PowerShell</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Microsoft-Windows-CodeIntegrity/Operational</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Microsoft-Windows-TaskScheduler/Operational</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Microsoft-Windows-PowerShell/Operational</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Microsoft-Windows-Windows Firewall With Advanced Security/Firewall</location>
      <log_format>eventchannel</log_format>
    </localfile>
    <localfile>
      <location>Microsoft-Windows-Windows Defender/Operational</location>
      <log_format>eventchannel</log_format>
    </localfile>
  </agent_config>