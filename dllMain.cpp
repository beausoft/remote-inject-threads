// dllmain.cpp : ���� DLL Ӧ�ó������ڵ㡣
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
		MessageBox( NULL, _T("DLL�ѽ���Ŀ����̡�"), _T("��Ϣ"), MB_ICONINFORMATION );
		break;
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		MessageBox( NULL, _T("DLL�Ѵ�Ŀ�����ж�ء�"), _T("��Ϣ"), MB_ICONINFORMATION );
		break;
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

