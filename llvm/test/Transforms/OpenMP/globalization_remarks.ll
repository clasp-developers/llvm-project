; RUN: opt -passes=openmp-opt -pass-remarks-missed=openmp-opt -disable-output < %s 2>&1 | FileCheck %s
; ModuleID = 'declare_target_codegen_globalization.cpp'
source_filename = "declare_target_codegen_globalization.cpp"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64"

; CHECK: remark: globalization_remarks.c:5:7: Found thread data sharing on the GPU. Expect degraded performance due to data globalization.

@S = external local_unnamed_addr global i8*

define void @foo() {
entry:
  %0 = call i8* @__kmpc_alloc_shared(i64 4), !dbg !8
  %x_on_stack = bitcast i8* %0 to i32*
  %1 = bitcast i32* %x_on_stack to i8*
  call void @share(i8* %1)
  call void @__kmpc_free_shared(i8* %0)
  ret void
}

define void @share(i8* %x) {
entry:
  store i8* %x, i8** @S
  ret void
}

declare i8* @__kmpc_alloc_shared(i64)

declare void @__kmpc_free_shared(i8*)


!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 12.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "globalization_remarks.c", directory: "/tmp/globalization_remarks.c")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!6 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !7, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!7 = !DISubroutineType(types: !2)
!8 = !DILocation(line: 5, column: 7, scope: !6)
