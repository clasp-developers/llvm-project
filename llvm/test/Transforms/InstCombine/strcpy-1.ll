; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the strcpy library call simplifier works correctly.
; rdar://6839935
; RUN: opt < %s -instcombine -S | FileCheck %s
;
; This transformation requires the pointer size, as it assumes that size_t is
; the size of a pointer.
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n8:16:32"

@hello = constant [6 x i8] c"hello\00"
@a = common global [32 x i8] zeroinitializer, align 1
@b = common global [32 x i8] zeroinitializer, align 1

declare i8* @strcpy(i8*, i8*)

define void @test_simplify1() {
; CHECK-LABEL: @test_simplify1(
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(6) getelementptr inbounds ([32 x i8], [32 x i8]* @a, i32 0, i32 0), i8* noundef nonnull align 1 dereferenceable(6) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i32 0, i32 0), i32 6, i1 false)
; CHECK-NEXT:    ret void
;

  %dst = getelementptr [32 x i8], [32 x i8]* @a, i32 0, i32 0
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0

  call i8* @strcpy(i8* %dst, i8* %src)
  ret void
}

define i8* @test_simplify2() {
; CHECK-LABEL: @test_simplify2(
; CHECK-NEXT:    ret i8* getelementptr inbounds ([32 x i8], [32 x i8]* @a, i32 0, i32 0)
;

  %dst = getelementptr [32 x i8], [32 x i8]* @a, i32 0, i32 0

  %ret = call i8* @strcpy(i8* %dst, i8* %dst)
  ret i8* %ret
}


define void @test_simplify3(i8* %dst) {
; CHECK-LABEL: @test_simplify3(
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(6) [[DST:%.*]], i8* noundef nonnull align 1 dereferenceable(6) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i32 0, i32 0), i32 6, i1 false)
; CHECK-NEXT:    ret void
;

  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0

  call i8* @strcpy(i8* dereferenceable(80) %dst, i8* %src)
  ret void
}

define i8* @test_no_simplify1() {
; CHECK-LABEL: @test_no_simplify1(
; CHECK-NEXT:    [[RET:%.*]] = call i8* @strcpy(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([32 x i8], [32 x i8]* @a, i32 0, i32 0), i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([32 x i8], [32 x i8]* @b, i32 0, i32 0))
; CHECK-NEXT:    ret i8* [[RET]]
;

  %dst = getelementptr [32 x i8], [32 x i8]* @a, i32 0, i32 0
  %src = getelementptr [32 x i8], [32 x i8]* @b, i32 0, i32 0

  %ret = call i8* @strcpy(i8* %dst, i8* %src)
  ret i8* %ret
}

define void @test_no_incompatible_attr() {
; CHECK-LABEL: @test_no_incompatible_attr(
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(6) getelementptr inbounds ([32 x i8], [32 x i8]* @a, i32 0, i32 0), i8* noundef nonnull align 1 dereferenceable(6) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i32 0, i32 0), i32 6, i1 false)
; CHECK-NEXT:    ret void
;

  %dst = getelementptr [32 x i8], [32 x i8]* @a, i32 0, i32 0
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0

  call dereferenceable(1) i8* @strcpy(i8* %dst, i8* %src)
  ret void
}
