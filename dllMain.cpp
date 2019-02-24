// dllmain.cpp : 定义 DLL 应用程序的入口点。
#include <windows.h>
#include <tchar.h>

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		MessageBox( NULL, _T("DLL已进入目标进程。"), _T("信息"), MB_ICONINFORMATION );
		break;
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		MessageBox( NULL, _T("DLL已从目标进程卸载。"), _T("信息"), MB_ICONINFORMATION );
		break;
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

