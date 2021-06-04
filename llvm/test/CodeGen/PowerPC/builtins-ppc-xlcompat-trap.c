// RUN: %clang_cc1 -O2 -triple powerpc64-unknown-unknown \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc64le-unknown-unknown \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc-unknown-aix \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s
// RUN: %clang_cc1 -O2 -triple powerpc64-unknown-aix \
// RUN:   -emit-llvm %s -o - -target-cpu pwr9 | FileCheck %s

long long lla, llb;
double da;
int ia, ib;

// tdw
void test_xl_tdw(void) {
// CHECK-LABEL: test_xl_tdw
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.tdw(i64 %0, i64 %1, i32 1)

  __tdw(lla, llb, 1);
}

void test_tdw(void) {
// CHECK-LABEL: test_tdw
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.tdw(i64 %0, i64 %1, i32 13)

  __tdw(lla, llb, 13);
}

// td
void test_tw(void) {
// CHECK-LABEL: test_tw
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.tw(i32 %0, i32 %1, i32 1)

  __tw(ia, ib, 1);
}

void test_xl_tw(void) {
// CHECK-LABEL: test_xl_tw
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.tw(i32 %0, i32 %1, i32 1)

  __tw(ia, ib, 1);
}

// trap
void test_trap(void) {
// CHECK-LABEL: test_trapd
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.trap(i32 %0)
  __builtin_ppc_trap(ia);
}

void test_xl_trap(void) {
// CHECK-LABEL: test_xl_trapd
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.trapd(i32 %0)
  __trap(ia);
}

// trapd
void test_trapd(void) {
// CHECK-LABEL: test_trapd
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.trapd(i64 %0)
  __builtin_ppc_trapd(da);
}

void test_xl_trapd(void) {
// CHECK-LABEL: test_xl_trapd
// CHECK-NEXT: entry:
// CHECK: void @llvm.ppc.trapd(i64 %0)
  __trapd(da);
}
