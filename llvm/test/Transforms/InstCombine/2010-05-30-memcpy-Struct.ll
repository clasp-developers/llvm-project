; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s
; PR7265

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%union.anon = type { i32, [4 x i8] }

@.str = private constant [3 x i8] c"%s\00"

define void @CopyEventArg(%union.anon* %ev) nounwind {
; CHECK-LABEL: @CopyEventArg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CSTR:%.*]] = bitcast %union.anon* [[EV:%.*]] to i8*
; CHECK-NEXT:    [[STRCPY:%.*]] = call i8* @strcpy(i8* noalias noundef nonnull returned writeonly dereferenceable(1) undef, i8* noalias nocapture noundef nonnull readonly dereferenceable(1) [[CSTR]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret void
;
entry:
  %call = call i32 (i8*, i8*, ...) @sprintf(i8* undef, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), %union.anon* %ev) nounwind
  ret void
}

declare i32 @sprintf(i8*, i8*, ...)

