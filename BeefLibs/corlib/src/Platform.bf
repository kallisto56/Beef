namespace System
{
	public interface INativeWindow
	{
	    int Handle { get; }
	}

	static class Platform
	{
		public const bool IsSingleProcessor = false;
		public const int ProcessorCount = 8;

		public struct BfpTimeStamp : uint64
        {

        }

		public enum Result : int32
		{
			Ok,
			UnknownError,
			InsufficientBuffer,
			NotSupported,
			NoResults,	
			InvalidParameter,
			Locked,
			AlreadyExists,
			NotFound,
			ShareError,
			AccessError,
			PartialData,
			TempFileError,
			Timeout,
			NotEmpty,
			PipeListening
		};

		public struct BfpSpawn {}
		public struct BfpFile {}
		public struct BfpFindFileData {}
		public struct BfpDynLib {}
		
		public struct BfpFileWatcher {}
		public struct BfpProcess {}
		public struct BfpTLS;
#if !BF_RUNTIME_DISABLE
		public struct BfpCritSect {}
		public struct BfpEvent {};
#else
		public struct BfpCritSect
		{
			public int mEmpty;
		}

		public struct BfpEvent
		{
			public bool mSet;
			public bool mAuto;
		};
#endif

		public enum BfpSystemResult : int32
		{
			Ok = (int)Result.Ok,
			UnknownError = (int)Result.UnknownError,
			TempFileError = (int)Result.TempFileError
		}

#if !BF_RUNTIME_DISABLE
		[StaticHook(typeof(SelfOuter))]
		public static struct Hook
		{
		}

		[CallingConvention(.Stdcall), CLink]
		public static extern uint32 BfpSystem_TickCount();
		[CallingConvention(.Stdcall), CLink]
		public static extern uint32 BfpSystem_SetCrashRelaunchCmd(char8* cmd);
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpTimeStamp BfpSystem_GetTimeStamp();
		[CallingConvention(.Stdcall), CLink]
		public static extern uint8 BfpSystem_InterlockedExchange8(uint8* ptr, uint8 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint16 BfpSystem_InterlockedExchange16(uint16* ptr, uint16 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint32 BfpSystem_InterlockedExchange32(uint32* ptr, uint32 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint64 BfpSystem_InterlockedExchange64(uint64* ptr, uint64 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint8 BfpSystem_InterlockedExchangeAdd8(uint8* ptr, uint8 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint16 BfpSystem_InterlockedExchangeAdd16(uint16* ptr, uint16 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint32 BfpSystem_InterlockedExchangeAdd32(uint32* ptr, uint32 val); /// Returns the initial value in 'ptr'
		[CallingConvention(.Stdcall), CLink]
		public static extern uint64 BfpSystem_InterlockedExchangeAdd64(uint64* ptr, uint64 val);
		[CallingConvention(.Stdcall), CLink]
		public static extern uint8 BfpSystem_InterlockedCompareExchange8(uint8* ptr, uint8 oldVal, uint8 newVal);
		[CallingConvention(.Stdcall), CLink]
		public static extern uint16 BfpSystem_InterlockedCompareExchange16(uint16* ptr, uint16 oldVal, uint16 newVal);
		[CallingConvention(.Stdcall), CLink]
		public static extern uint32 BfpSystem_InterlockedCompareExchange32(uint32* ptr, uint32 oldVal, uint32 newVal);
		[CallingConvention(.Stdcall), CLink]
		public static extern uint64 BfpSystem_InterlockedCompareExchange64(uint64* ptr, uint64 oldVal, uint64 newVal);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSystem_GetExecutablePath(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSystem_GetEnvironmentStrings(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern int32 BfpSystem_GetNumLogicalCPUs(BfpSystemResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern int64 BfpSystem_GetCPUTick();
		[CallingConvention(.Stdcall), CLink]
		public static extern int64 BfpSystem_GetCPUTickFreq();
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSystem_CreateGUID(Guid* outGuid);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSystem_GetComputerName(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult);

		[CallingConvention(.Stdcall), CLink]
		public static extern int BfpThread_GetCurrentId();

		[CallingConvention(.Stdcall), CLink]
		public static extern BfpTLS* BfpTLS_Create(function [CallingConvention(.Stdcall)] void(void*) exitProc);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpTLS_Release(BfpTLS* tls);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpTLS_SetValue(BfpTLS* tls, void* value);
		[CallingConvention(.Stdcall), CLink]
		public static extern void* BfpTLS_GetValue(BfpTLS* tls);
#else
		public typealias Hook = Self;
		
		public static uint32 BfpSystem_TickCount() => Runtime.NotImplemented();
		
		public static uint32 BfpSystem_SetCrashRelaunchCmd(char8* cmd) => Runtime.NotImplemented();
		
		public static BfpTimeStamp BfpSystem_GetTimeStamp() => Runtime.NotImplemented();
		
		public static uint8 BfpSystem_InterlockedExchange8(uint8* ptr, uint8 val) => Runtime.NotImplemented();
		
		public static uint16 BfpSystem_InterlockedExchange16(uint16* ptr, uint16 val) => Runtime.NotImplemented();
		
		public static uint32 BfpSystem_InterlockedExchange32(uint32* ptr, uint32 val) => Runtime.NotImplemented();
		
		public static uint64 BfpSystem_InterlockedExchange64(uint64* ptr, uint64 val) => Runtime.NotImplemented();
		
		public static uint8 BfpSystem_InterlockedExchangeAdd8(uint8* ptr, uint8 val) => Runtime.NotImplemented();
		
		public static uint16 BfpSystem_InterlockedExchangeAdd16(uint16* ptr, uint16 val) => Runtime.NotImplemented(); /// Returns the initial value in 'ptr'
		
		public static uint32 BfpSystem_InterlockedExchangeAdd32(uint32* ptr, uint32 val) => Runtime.NotImplemented(); /// Returns the initial value in 'ptr'
		
		public static uint64 BfpSystem_InterlockedExchangeAdd64(uint64* ptr, uint64 val) => Runtime.NotImplemented();
		
		public static uint8 BfpSystem_InterlockedCompareExchange8(uint8* ptr, uint8 oldVal, uint8 newVal) => Runtime.NotImplemented();
		
		public static uint16 BfpSystem_InterlockedCompareExchange16(uint16* ptr, uint16 oldVal, uint16 newVal) => Runtime.NotImplemented();
		
		public static uint32 BfpSystem_InterlockedCompareExchange32(uint32* ptr, uint32 oldVal, uint32 newVal) => Runtime.NotImplemented();
		
		public static uint64 BfpSystem_InterlockedCompareExchange64(uint64* ptr, uint64 oldVal, uint64 newVal) => Runtime.NotImplemented();
		
		public static void BfpSystem_GetExecutablePath(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpSystem_GetEnvironmentStrings(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult) => Runtime.NotImplemented();
		
		public static int32 BfpSystem_GetNumLogicalCPUs(BfpSystemResult* outResult) => Runtime.NotImplemented();
		
		public static int64 BfpSystem_GetCPUTick() => Runtime.NotImplemented();
		
		public static int64 BfpSystem_GetCPUTickFreq() => Runtime.NotImplemented();
		
		public static void BfpSystem_CreateGUID(Guid* outGuid) => Runtime.NotImplemented();
		
		public static void BfpSystem_GetComputerName(char8* outStr, int32* inOutStrSize, BfpSystemResult* outResult) => Runtime.NotImplemented();

		public static int BfpThread_GetCurrentId() => Runtime.NotImplemented();
		
		public static BfpTLS* BfpTLS_Create(function [CallingConvention(.Stdcall)] void(void*) exitProc) => Runtime.NotImplemented();
		
		public static void BfpTLS_Release(BfpTLS* tls) => Runtime.NotImplemented();
		
		public static void BfpTLS_SetValue(BfpTLS* tls, void* value) => Runtime.NotImplemented();
	
		public static void* BfpTLS_GetValue(BfpTLS* tls) => Runtime.NotImplemented();
#endif

		public enum BfpFileWatcherFlags : int32
		{
			None = 0,
			IncludeSubdirectories = 1
		};

		public enum BfpFileChangeKind : int32
		{
			BfpFileChangeKind_Added,
			BfpFileChangeKind_Removed,
			BfpFileChangeKind_Modified,
			BfpFileChangeKind_Renamed,	
			BfpFileChangeKind_Failed
		};

		public function void BfpDirectoryChangeFunc(BfpFileWatcher* watcher, void* userData, BfpFileChangeKind changeKind, char8* directory, char8* fileName, char8* oldName);

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpFileWatcher* BfpFileWatcher_WatchDirectory(char8* path, BfpDirectoryChangeFunc callback, BfpFileWatcherFlags flags, void* userData, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpFileWatcher_Release(BfpFileWatcher* fileWatcher);
#else
		public static BfpFileWatcher* BfpFileWatcher_WatchDirectory(char8* path, BfpDirectoryChangeFunc callback, BfpFileWatcherFlags flags, void* userData, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFileWatcher_Release(BfpFileWatcher* fileWatcher) => Runtime.NotImplemented();
#endif

		public enum BfpProcessResult : int32
		{
			Ok = (int)Result.Ok,
			NotFound = (int)Result.NotFound,
			InsufficientBuffer = (int)Result.InsufficientBuffer,
			UnknownError = (int)Result.UnknownError,
		}

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpProcess_IsRemoteMachine(char8* machineName);
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpProcess* BfpProcess_GetById(char8* machineName, int32 processId, BfpProcessResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpProcess_Enumerate(char8* machineName, BfpProcess** outProcesses, int32* inOutProcessesSize, BfpProcessResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpProcess_Release(BfpProcess* process);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpProcess_GetMainWindowTitle(BfpProcess* process, char8* outTitle, int32* inOutTitleSize, BfpProcessResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpProcess_GetProcessName(BfpProcess* process, char8* outName, int32* inOutNameSize, BfpProcessResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern int32 BfpProcess_GetProcessId(BfpProcess* process);
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpProcess_WaitFor(BfpProcess* process, int waitMS, int* outExitCode, BfpProcessResult* outResult);

#else
		
		public static bool BfpProcess_IsRemoteMachine(char8* machineName) => Runtime.NotImplemented();
		
		public static BfpProcess* BfpProcess_GetById(char8* machineName, int32 processId, BfpProcessResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpProcess_Enumerate(char8* machineName, BfpProcess** outProcesses, int32* inOutProcessesSize, BfpProcessResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpProcess_Release(BfpProcess* process) => Runtime.NotImplemented();
		
		public static void BfpProcess_GetMainWindowTitle(BfpProcess* process, char8* outTitle, int32* inOutTitleSize, BfpProcessResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpProcess_GetProcessName(BfpProcess* process, char8* outName, int32* inOutNameSize, BfpProcessResult* outResult) => Runtime.NotImplemented();
		
		public static int32 BfpProcess_GetProcessId(BfpProcess* process) => Runtime.NotImplemented();

		public static int BfpSpawn_GetProcessId(BfpSpawn* spawn) => Runtime.NotImplemented();;
#endif

		public enum BfpSpawnFlags : int32
		{
			None = 0,
			ArgsIncludesTarget = 1, // Otherwise most platforms prepend targetPath to the args	
			UseArgsFile = 2,
			UseArgsFile_Native = 4,
			UseArgsFile_UTF8 = 8,
			UseArgsFile_BOM = 0x10,
			UseShellExecute = 0x20, // Allows opening non-executable files by file association (ie: documents)
			RedirectStdInput = 0x40,
			RedirectStdOutput = 0x80,
			RedirectStdError = 0x100,
			NoWindow = 0x200,
			ErrorDialog = 0x400,
			Window_Hide = 0x800,
			Window_Maximized = 0x1000,
			NoActivateWindow = 0x2000
		};

		public enum BfpKillFlags : int32
		{
			None = 0,
			KillChildren = 1
		}

		public enum BfpSpawnResult : int32
		{
		    Ok = (int)Result.Ok,
			UnknownError = (int)Result.UnknownError
		};

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpSpawn* BfpSpawn_Create(char8* targetPath, char8* args, char8* workingDir, char8* env, BfpSpawnFlags flags, BfpSpawnResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSpawn_Release(BfpSpawn* spawn);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSpawn_Kill(BfpSpawn* spawn, int32 exitCode, BfpKillFlags killFlags, BfpSpawnResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpSpawn_WaitFor(BfpSpawn* spawn, int waitMS, int* outExitCode, BfpSpawnResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpSpawn_GetStdHandles(BfpSpawn* spawn, BfpFile** outStdIn, BfpFile** outStdOut, BfpFile** outStdErr);
		[CallingConvention(.Stdcall), CLink]
		public static extern int BfpSpawn_GetProcessId(BfpSpawn* spawn);

		[CallingConvention(.Stdcall), CLink]
		public static extern int BfpProcess_GetCurrentId();

		[CallingConvention(.Stdcall), CLink]
        public static extern BfpCritSect* BfpCritSect_Create();
		[CallingConvention(.Stdcall), CLink]
        public static extern void BfpCritSect_Release(BfpCritSect* critSect);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpCritSect_Enter(BfpCritSect* critSect);
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpCritSect_TryEnter(BfpCritSect* critSect, int32 waitMS);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpCritSect_Leave(BfpCritSect* critSect);
#else

		public static BfpSpawn* BfpSpawn_Create(char8* targetPath, char8* args, char8* workingDir, char8* env, BfpSpawnFlags flags, BfpSpawnResult* outResult)
		{
			*outResult = .UnknownError;
			return null;
		}
		
		public static void BfpSpawn_Release(BfpSpawn* spawn) => Runtime.NotImplemented();
		
		public static void BfpSpawn_Kill(BfpSpawn* spawn, int32 exitCode, BfpKillFlags killFlags, BfpSpawnResult* outResult) => Runtime.NotImplemented();
		
		public static bool BfpSpawn_WaitFor(BfpSpawn* spawn, int waitMS, int* outExitCode, BfpSpawnResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpSpawn_GetStdHandles(BfpSpawn* spawn, BfpFile** outStdIn, BfpFile** outStdOut, BfpFile** outStdErr) => Runtime.NotImplemented();

		
		public static int BfpProcess_GetCurrentId() => Runtime.NotImplemented();

		public static BfpCritSect* BfpCritSect_Create() => new BfpCritSect();
		
		public static void BfpCritSect_Release(BfpCritSect* critSect)
		{
			delete critSect;
		}
		
		public static void BfpCritSect_Enter(BfpCritSect* critSect)
		{

		}
		
		public static bool BfpCritSect_TryEnter(BfpCritSect* critSect, int32 waitMS)
		{
			return true;
		}
		
		public static void BfpCritSect_Leave(BfpCritSect* critSect)
		{

		}
#endif

		public enum BfpEventFlags : int32
		{
			None = 0,
			AllowAutoReset = 1,
			AllowManualReset = 2,
			InitiallySet_Auto = 4,
			InitiallySet_Manual = 8
		};

		public enum BfpEventResult : int32
		{
			BfpEventResult_Ok				= (int)Result.Ok,
			BfpEventResult_NotSupported		= (int)Result.NotSupported
		};

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpEvent* BfpEvent_Create(BfpEventFlags flags);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpEvent_Release(BfpEvent* event);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpEvent_Set(BfpEvent* event, bool requireManualReset);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpEvent_Reset(BfpEvent* event, BfpEventResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpEvent_WaitFor(BfpEvent* event, int32 waitMS);
#else
		
		public static BfpEvent* BfpEvent_Create(BfpEventFlags flags)
		{
			var result = new BfpEvent();
			result.mSet = flags.HasFlag(.InitiallySet_Auto) | flags.HasFlag(.InitiallySet_Manual);
			result.mAuto = flags.HasFlag(.InitiallySet_Auto);
			return result;
		}
		
		public static void BfpEvent_Release(BfpEvent* event)
		{
			delete event;
		}
		
		public static void BfpEvent_Set(BfpEvent* event, bool requireManualReset)
		{
			event.mSet = true;
			event.mAuto = !requireManualReset;
		}
		
		public static void BfpEvent_Reset(BfpEvent* event, BfpEventResult* outResult)
		{
			event.mSet = false;
			event.mAuto = false;
			*outResult = .BfpEventResult_Ok;
		}
		
		public static bool BfpEvent_WaitFor(BfpEvent* event, int32 waitMS)
		{
			if (!event.mSet)
				return false;
			if (event.mAuto)
			{
				event.mSet = false;
				event.mAuto = false;
			}
			return true;
		}
#endif

		public enum BfpLibResult : int32
		{
		    Ok                  = (int)Result.Ok,
			UnknownError		= (int)Result.UnknownError,
		    InsufficientBuffer  = (int)Result.InsufficientBuffer
		};

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern BfpDynLib* BfpDynLib_Load(char8* fileName);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDynLib_Release(BfpDynLib* lib);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDynLib_GetFilePath(BfpDynLib* lib, char8* outPath, int32* inOutPathSize, BfpLibResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void* BfpDynLib_GetProcAddress(BfpDynLib* lib, char8* name);
#else
		
		public static BfpDynLib* BfpDynLib_Load(char8* fileName) => Runtime.NotImplemented();
		
		public static void BfpDynLib_Release(BfpDynLib* lib) => Runtime.NotImplemented();
		
		public static void BfpDynLib_GetFilePath(BfpDynLib* lib, char8* outPath, int32* inOutPathSize, BfpLibResult* outResult) => Runtime.NotImplemented();
		
		public static void* BfpDynLib_GetProcAddress(BfpDynLib* lib, char8* name) => Runtime.NotImplemented();
#endif

		public enum BfpFileResult : int32
		{
			Ok						= (int)Result.Ok,
			NoResults				= (int)Result.NoResults,
			UnknownError			= (int)Result.UnknownError,
			InvalidParameter		= (int)Result.InvalidParameter,
			Locked					= (int)Result.Locked,
			AlreadyExists			= (int)Result.AlreadyExists,
			NotFound				= (int)Result.NotFound,
			ShareError				= (int)Result.ShareError,
			AccessError				= (int)Result.AccessError,
			PartialData				= (int)Result.PartialData,
			InsufficientBuffer		= (int)Result.InsufficientBuffer,
			Timeout					= (int)Result.Timeout,
			NotEmpty				= (int)Result.NotEmpty,
			PipeListening			= (int)Result.PipeListening,
		};

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_Create(char8* name, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_Rename(char8* oldName, char8* newName, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_Delete(char8* name, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_GetCurrent(char8* outPath, int32* inOutPathSize, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_SetCurrent(char8* path, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink]
		public static extern bool BfpDirectory_Exists(char8* path);
		[CallingConvention(.Stdcall), CLink]
		public static extern void BfpDirectory_GetSysDirectory(BfpSysDirectoryKind sysDirKind, char8* outPath, int32* inOutPathLen, BfpFileResult* outResult);
#else
		
		public static void BfpDirectory_Create(char8* name, BfpFileResult* outResult) { *outResult = .UnknownError; }
		
		public static void BfpDirectory_Rename(char8* oldName, char8* newName, BfpFileResult* outResult) { *outResult = .UnknownError; }
		
		public static void BfpDirectory_Delete(char8* name, BfpFileResult* outResult) { *outResult = .UnknownError; }
		
		public static void BfpDirectory_GetCurrent(char8* outPath, int32* inOutPathSize, BfpFileResult* outResult) { *outResult = .UnknownError; }
		
		public static void BfpDirectory_SetCurrent(char8* path, BfpFileResult* outResult) { *outResult = .UnknownError; }
		
		public static bool BfpDirectory_Exists(char8* path) => false;
		
		public static void BfpDirectory_GetSysDirectory(BfpSysDirectoryKind sysDirKind, char8* outPath, int32* inOutPathLen, BfpFileResult* outResult) { *outResult = .UnknownError; }
#endif

		public enum BfpFileCreateKind : int32
		{
			CreateAlways,
			CreateIfNotExists,
			OpenExisting,
			OpenAlways,
		};

		public enum BfpFileCreateFlags : int32
		{
			None = 0,
			Read = 1,
			Write = 2,		

			ShareRead = 4,
			ShareWrite = 8,
			ShareDelete = 0x10,
			
			Append = 0x20,
			Truncate = 0x40,

			WriteThrough = 0x80,
			DeleteOnClose = 0x100,
			NoBuffering = 0x200,

			NonBlocking = 0x400,
			AllowTimeouts = 0x800,
			Pipe = 0x1000,
		};

		public enum BfpFileSeekKind : int32
		{
			Absolute,
			Relative,
			FromEnd
		};

		public enum BfpFileAttributes : int32
		{
			None = 0,
			Normal = 1,
			Directory = 2,
			SymLink = 4,
			Device = 8,
			ReadOnly = 0x10,
			Hidden = 0x20,
			System = 0x40,
			Temporary = 0x80,
			Offline = 0x100,
			Encrypted = 0x200,
			Archive = 0x400,
		};

		public enum BfpFileCopyKind : int32
		{
			Always,
			IfNotExists,
			IfNewer,
		};

		public enum BfpFileStdKind : int32
		{
			Out,
			Error,
			In
		}

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpFile* BfpFile_Create(char8* name, BfpFileCreateKind createKind, BfpFileCreateFlags createFlags, BfpFileAttributes createdFileAttrs, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpFile* BfpFile_GetStd(BfpFileStdKind kind, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int BfpFile_GetSystemHandle(BfpFile* file);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Release(BfpFile* file);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int BfpFile_Write(BfpFile* file, void* buffer, int size, int timeoutMS, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int BfpFile_Read(BfpFile* file, void* buffer, int size, int timeoutMS, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Flush(BfpFile* file);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int64 BfpFile_GetFileSize(BfpFile* file);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int64 BfpFile_Seek(BfpFile* file, int64 offset, BfpFileSeekKind seekKind);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Truncate(BfpFile* file, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpTimeStamp BfpFile_GetTime_LastWrite(char8* path);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpFileAttributes BfpFile_GetAttributes(char8* path, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_SetAttributes(char8* path, BfpFileAttributes attribs, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Copy(char8* oldPath, char8* newPath, BfpFileCopyKind copyKind, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Rename(char8* oldPath, char8* newPath, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_Delete(char8* path, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern bool BfpFile_Exists(char8* path);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_GetTempPath(char8* outPath, int32* inOutPathSize, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_GetTempFileName(char8* outName, int32* inOutNameSize, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_GetFullPath(char8* inPath, char8* outPath, int32* inOutPathSize, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFile_GetActualPath(char8* inPath, char8* outPath, int32* inOutPathSize, BfpFileResult* outResult);
#else
		
		public static BfpFile* BfpFile_Create(char8* name, BfpFileCreateKind createKind, BfpFileCreateFlags createFlags, BfpFileAttributes createdFileAttrs, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static BfpFile* BfpFile_GetStd(BfpFileStdKind kind, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static int BfpFile_GetSystemHandle(BfpFile* file) => Runtime.NotImplemented();
		
		public static void BfpFile_Release(BfpFile* file) => Runtime.NotImplemented();
		
		public static int BfpFile_Write(BfpFile* file, void* buffer, int size, int timeoutMS, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static int BfpFile_Read(BfpFile* file, void* buffer, int size, int timeoutMS, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_Flush(BfpFile* file) => Runtime.NotImplemented();
		
		public static int64 BfpFile_GetFileSize(BfpFile* file) => Runtime.NotImplemented();
		
		public static int64 BfpFile_Seek(BfpFile* file, int64 offset, BfpFileSeekKind seekKind) => Runtime.NotImplemented();
		
		public static void BfpFile_Truncate(BfpFile* file, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static BfpTimeStamp BfpFile_GetTime_LastWrite(char8* path) => Runtime.NotImplemented();
		
		public static BfpFileAttributes BfpFile_GetAttributes(char8* path, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_SetAttributes(char8* path, BfpFileAttributes attribs, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_Copy(char8* oldPath, char8* newPath, BfpFileCopyKind copyKind, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_Rename(char8* oldPath, char8* newPath, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_Delete(char8* path, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static bool BfpFile_Exists(char8* path) => Runtime.NotImplemented();
		
		public static void BfpFile_GetTempPath(char8* outPath, int32* inOutPathSize, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_GetTempFileName(char8* outName, int32* inOutNameSize, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_GetFullPath(char8* inPath, char8* outPath, int32* inOutPathSize, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static void BfpFile_GetActualPath(char8* inPath, char8* outPath, int32* inOutPathSize, BfpFileResult* outResult) => Runtime.NotImplemented();
#endif

		public enum BfpFindFileFlags : int32
		{
			None = 0,
			Files = 1,
			Directories = 2,
		};

#if !BF_RUNTIME_DISABLE
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpFindFileData* BfpFindFileData_FindFirstFile(char8* path, BfpFindFileFlags flags, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern bool BfpFindFileData_FindNextFile(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFindFileData_GetFileName(BfpFindFileData* findData, char8* outName, int32* inOutNameSize, BfpFileResult* outResult);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpTimeStamp BfpFindFileData_GetTime_LastWrite(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpTimeStamp BfpFindFileData_GetTime_Created(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpTimeStamp BfpFindFileData_GetTime_Access(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern BfpFileAttributes BfpFindFileData_GetFileAttributes(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern int64 BfpFindFileData_GetFileSize(BfpFindFileData* findData);
		[CallingConvention(.Stdcall), CLink, StaticHook]
		public static extern void BfpFindFileData_Release(BfpFindFileData* findData);
#else
		
		public static BfpFindFileData* BfpFindFileData_FindFirstFile(char8* path, BfpFindFileFlags flags, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static bool BfpFindFileData_FindNextFile(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static void BfpFindFileData_GetFileName(BfpFindFileData* findData, char8* outName, int32* inOutNameSize, BfpFileResult* outResult) => Runtime.NotImplemented();
		
		public static BfpTimeStamp BfpFindFileData_GetTime_LastWrite(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static BfpTimeStamp BfpFindFileData_GetTime_Created(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static BfpTimeStamp BfpFindFileData_GetTime_Access(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static BfpFileAttributes BfpFindFileData_GetFileAttributes(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static int64 BfpFindFileData_GetFileSize(BfpFindFileData* findData) => Runtime.NotImplemented();
		
		public static void BfpFindFileData_Release(BfpFindFileData* findData) => Runtime.NotImplemented();
#endif

		public enum BfpSysDirectoryKind : int32
		{
			Default, // Home on Linux, Desktop on Windows, etc.
			Home,
			System,
			Desktop,
			Desktop_Common,
			AppData_Local,
			AppData_LocalLow,
			AppData_Roaming,
			Programs,
			Programs_Common,
			Documents
		}

		public static bool SetStrHelper(StringView str, char8* outStr, int32* inOutSize, Result* outResult)
		{
			if (str.Length > *inOutSize + 1)
			{
				*inOutSize = (.)str.Length + 1;
				*outResult = .InsufficientBuffer;
				return false;
			}
			*inOutSize = (.)str.Length + 1;
			Internal.MemCpy(outStr, str.Ptr, str.Length);
			outStr[str.Length] = 0;
			return true;
		}

		public static Result<void, Platform.Result> GetStrHelper(String outStr, delegate void (char8* outPtr, int32* outSize, Result* outResult) func)
		{
			let initSize = 4096;
			char8* localBuf = scope char8[initSize]*;

			int32 strSize = initSize;
			Result result = .Ok;
			func(localBuf, &strSize, &result);

			if (result == .Ok)
			{
				outStr.Append(localBuf, strSize - 1);
				return .Ok;
			}
			else if (result == .InsufficientBuffer)
			{
				while (true)
				{
					localBuf = scope char8[strSize]*;
					func(localBuf, &strSize, &result);

					if (result == .InsufficientBuffer)
						continue;
					outStr.Append(localBuf, strSize - 1);
					return .Ok;
				}
			}

			return .Err(result);
		}

		public static Result<Span<T>, Platform.Result> GetSizedHelper<T>(delegate void (T* outPtr, int32* outSize, Result* outResult) func)
		{
			T* vals;
			int32 trySize = 64;
			while (true)
			{
				vals = new T[trySize]*;

				int32 inOutSize = trySize;
				Result result = .Ok;
				func(vals, &inOutSize, &result);

				if ((result != .InsufficientBuffer) && (result != .Ok))
					return .Err(result);
				
				if (result == .Ok)
					return .Ok(Span<T>(vals, inOutSize));

				delete (void*)vals;
				trySize = inOutSize;
			}
		}
	}
}
