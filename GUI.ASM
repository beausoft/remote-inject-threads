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
szjsq db '计算器',0
szdll db 'Kernel32.dll',0
szLoad db 'LoadLibraryA',0
szMDll db '\dllMain.dll',0
szOperation db 'open',0
szFileName db 'calc.exe',0
.code
start:
			invoke GetCurrentDirectory,MAX_PATH,addr Full;获取当前文件路径
			invoke lstrcat,addr Full,addr szMDll;当前路径连接上我们的DLL文件名
			invoke GetModuleHandle,addr szdll;获取模块
			invoke GetProcAddress,eax,addr szLoad;获取LoadLibrary函数地址
			mov lpLoad,eax;保存地址
			invoke FindWindow,NULL,addr szjsq;获取窗口句柄
			mov Processhand,eax;保存窗口句柄
			invoke GetWindowThreadProcessId,Processhand,offset ProcessID;获取进程ID
			mov ThreadID,eax;保存线程ID
			invoke OpenProcess,PROCESS_CREATE_THREAD or PROCESS_VM_OPERATION or \
			PROCESS_VM_WRITE,FALSE,ProcessID;打开指定进程
			mov hand,eax;保存返回句柄
			invoke VirtualAllocEx,hand,NULL,MAX_PATH,MEM_COMMIT,PAGE_READWRITE;在目标进程申请内存
			mov DllName,eax;保存申请的地址
			invoke WriteProcessMemory,hand,eax,offset Full,MAX_PATH,NULL;把DLL写入目标进程
			invoke CreateRemoteThread,hand,NULL,0,lpLoad,\
						DllName,0,NULL;在目标进程中创建线程
			invoke ShowWindow,Processhand,NULL;隐藏窗口
			invoke CloseHandle,eax;关闭句并
			invoke CloseHandle,hand
			invoke ExitProcess,NULL
end start