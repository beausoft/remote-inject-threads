.386
.model flat, stdcall
option casemap :none

include windows.inc
include gdi32.inc
includelib gdi32.lib
include user32.inc
includelib user32.lib
include kernel32.inc
includelib kernel32.lib
include shell32.inc
includelib shell32.lib

.data?
ProcessID dd ?
Processhand dd ?
ThreadID dd ?
Applicationhand dd ?
hand dd ?
lpLoad dd ?
DllName dd ?
Full db MAX_PATH dup (?)
.const
szjsq db '������',0
szdll db 'Kernel32.dll',0
szLoad db 'LoadLibraryA',0
szMDll db '\dllMain.dll',0
szOperation db 'open',0
szFileName db 'calc.exe',0
.code
start:
			invoke GetCurrentDirectory,MAX_PATH,addr Full;��ȡ��ǰ�ļ�·��
			invoke lstrcat,addr Full,addr szMDll;��ǰ·�����������ǵ�DLL�ļ���
			invoke GetModuleHandle,addr szdll;��ȡģ��
			invoke GetProcAddress,eax,addr szLoad;��ȡLoadLibrary������ַ
			mov lpLoad,eax;�����ַ
			invoke FindWindow,NULL,addr szjsq;��ȡ���ھ��
			mov Processhand,eax;���洰�ھ��
			invoke GetWindowThreadProcessId,Processhand,offset ProcessID;��ȡ����ID
			mov ThreadID,eax;�����߳�ID
			invoke OpenProcess,PROCESS_CREATE_THREAD or PROCESS_VM_OPERATION or \
			PROCESS_VM_WRITE,FALSE,ProcessID;��ָ������
			mov hand,eax;���淵�ؾ��
			invoke VirtualAllocEx,hand,NULL,MAX_PATH,MEM_COMMIT,PAGE_READWRITE;��Ŀ����������ڴ�
			mov DllName,eax;��������ĵ�ַ
			invoke WriteProcessMemory,hand,eax,offset Full,MAX_PATH,NULL;��DLLд��Ŀ�����
			invoke CreateRemoteThread,hand,NULL,0,lpLoad,\
						DllName,0,NULL;��Ŀ������д����߳�
			invoke ShowWindow,Processhand,NULL;���ش���
			invoke CloseHandle,eax;�رվ䲢
			invoke CloseHandle,hand
			invoke ExitProcess,NULL
end start