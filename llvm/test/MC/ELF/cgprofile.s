# RUN: llvm-mc -filetype=obj -triple x86_64-pc-linux-gnu %s -o - | llvm-readobj -S --symbols --sd --cg-profile - | FileCheck %s

  .section .test,"aw",@progbits
a: .word b

  .cg_profile a, b, 32
  .cg_profile freq, a, 11
  .cg_profile late, late2, 20
  .cg_profile .L.local, b, 42

	.globl late
late:
late2: .word 0
late3:
.L.local:

# CHECK:      Name: .llvm.call-graph-profile
# CHECK-NEXT: Type: SHT_LLVM_CALL_GRAPH_PROFILE (0x6FFF4C09)
# CHECK-NEXT: Flags [ (0x80000000)
# CHECK-NEXT: SHF_EXCLUDE (0x80000000)
# CHECK-NEXT: ]
# CHECK-NEXT: Address:
# CHECK-NEXT: Offset:
# CHECK-NEXT: Size: 32
# CHECK-NEXT: Link: 7
# CHECK-NEXT: Info: 0
# CHECK-NEXT: AddressAlignment: 1
# CHECK-NEXT: EntrySize: 8
# CHECK-NEXT: SectionData (
# CHECK-NEXT:   0000: 20000000 00000000 0B000000 00000000
# CHECK-NEXT:   0010: 14000000 00000000 2A000000 00000000
# CHECK-NEXT: )

# CHECK:      Name: .rela.llvm.call-graph-profile (28)
# CHECK-NEXT: Type: SHT_RELA (0x4)
# CHECK-NEXT: Flags [ (0x0)
# CHECK-NEXT: ]
# CHECK-NEXT: Address: 0x0
# CHECK-NEXT: Offset: 0x140
# CHECK-NEXT: Size: 192
# CHECK-NEXT: Link: 7
# CHECK-NEXT: Info: 5
# CHECK-NEXT: AddressAlignment: 8
# CHECK-NEXT: EntrySize: 24
# CHECK-NEXT: SectionData (
# CHECK-NEXT:   0000: 00000000 00000000 00000000 02000000
# CHECK-NEXT:   0010: 00000000 00000000 01000000 00000000
# CHECK-NEXT:   0020: 00000000 05000000 00000000 00000000
# CHECK-NEXT:   0030: 02000000 00000000 00000000 07000000
# CHECK-NEXT:   0040: 00000000 00000000 03000000 00000000
# CHECK-NEXT:   0050: 00000000 02000000 00000000 00000000
# CHECK-NEXT:   0060: 04000000 00000000 00000000 06000000
# CHECK-NEXT:   0070: 00000000 00000000 05000000 00000000
# CHECK-NEXT:   0080: 00000000 03000000 00000000 00000000
# CHECK-NEXT:   0090: 06000000 00000000 00000000 01000000
# CHECK-NEXT:   00A0: 00000000 00000000 07000000 00000000
# CHECK-NEXT:   00B0: 00000000 05000000 00000000 00000000
# CHECK-NEXT: )

# CHECK: Symbols [
# CHECK:      Name: a
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Local
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: .test
# CHECK:      Name: late2
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Local
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: .test
# CHECK:      Name: late3
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Local
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: .test
# CHECK:      Name: b
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Global
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: Undefined
# CHECK:      Name: late
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Global
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: .test
# CHECK:      Name: freq
# CHECK-NEXT: Value:
# CHECK-NEXT: Size:
# CHECK-NEXT: Binding: Global
# CHECK-NEXT: Type:
# CHECK-NEXT: Other:
# CHECK-NEXT: Section: Undefined
# CHECK:      CGProfile [
# CHECK-NEXT:   CGProfileEntry {
# CHECK-NEXT:     From: a
# CHECK-NEXT:     To: b
# CHECK-NEXT:     Weight: 32
# CHECK-NEXT:   }
# CHECK-NEXT:   CGProfileEntry {
# CHECK-NEXT:     From: freq
# CHECK-NEXT:     To: a
# CHECK-NEXT:     Weight: 11
# CHECK-NEXT:   }
# CHECK-NEXT:   CGProfileEntry {
# CHECK-NEXT:     From: late
# CHECK-NEXT:     To: late2
# CHECK-NEXT:     Weight: 20
# CHECK-NEXT:   }
# CHECK-NEXT:   CGProfileEntry {
# CHECK-NEXT:     From:
# CHECK-NEXT:     To: b
# CHECK-NEXT:     Weight: 42
# CHECK-NEXT:   }
# CHECK-NEXT: ]
