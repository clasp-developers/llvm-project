// RUN: %clang_cc1 -O2 -triple powerpc64-unknown-unknown \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc64le-unknown-unknown \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc-unknown-aix \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc64-unknown-aix \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s

double test_fcfid(double a) {
  // CHECK-LABEL: test_fcfid
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fcfid(double %0)
  return __builtin_ppc_fcfid(a);
}

double test_xl_fcfid(double a) {
  // CHECK-LABEL: test_xl_fcfid
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fcfid(double %0)
  return __fcfid(a);
}

double test_fcfud(double a) {
  // CHECK-LABEL: test_fcfud
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fcfud(double %0)
  return __builtin_ppc_fcfud(a);
}

double test_xl_fcfud(double a) {
  // CHECK-LABEL: test_xl_fcfud
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fcfud(double %0)
  return __fcfud(a);
}

double test_fctid(double a) {
  // CHECK-LABEL: test_fctid
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctid(a);
}

double test_xl_fctid(double a) {
  // CHECK-LABEL: test_xl_fctid
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctid(a);
}

double test_fctidz(double a) {
  // CHECK-LABEL: test_fctidz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctidz(a);
}

double test_xl_fctidz(double a) {
  // CHECK-LABEL: test_xl_fctidz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctidz(a);
}

double test_fctiw(double a) {
  // CHECK-LABEL: test_fctiw
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctiw(a);
}

double test_xl_fctiw(double a) {
  // CHECK-LABEL: test_xl_fctiw
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctiw(a);
}

double test_fctiwz(double a) {
  // CHECK-LABEL: test_fctiwz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctiwz(a);
}

double test_xl_fctiwz(double a) {
  // CHECK-LABEL: test_xl_fctiwz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctiwz(a);
}

double test_fctudz(double a) {
  // CHECK-LABEL: test_fctudz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctudz(a);
}

double test_xl_fctudz(double a) {
  // CHECK-LABEL: test_xl_fctudz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctudz(a);
}

double test_fctuwz(double a) {
  // CHECK-LABEL: test_fctuwz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __builtin_ppc_fctuwz(a);
}

double test_xl_fctuwz(double a) {
  // CHECK-LABEL: test_xl_fctuwz
  // CHECK-NEXT: entry:
  // CHECK: double @llvm.ppc.fctid(double %0)
  return __fctuwz(a);
}