Apps
====

Firefox 68.11.0
---------------

Download Firefox for Android (fennec) last version 68.11.0:

- https://archive.mozilla.org/pub/mobile/releases/68.11.0/

This is the last version to support:

- Add-ons (Violentmonkey, Stylus, all)
- View page source
- Save as PDF
- etc.

Check your CPU architecure (ABI) with CPU Info app:

- https://github.com/kamgurgul/cpu-info
- https://play.google.com/store/apps/details?id=com.kgurgul.cpuinfo

You must (temporarily) allow to install APK from outside of Play Store.

APK (Android app install package) is available in [aarch64], api-16 (arm), x86 ([i386]) and [x86_64].
You can use https://developer.android.com/ndk/guides/abis to find out which one matches your ABI.
For instance, Xiaomi Redmi 7 arm64-v8a ABI, seems to match AArch64 APK download (APK hot linked):

| ABI           | Supported Instruction Sets | Notes
|---------------|----------------------------|------
| armeabi-v7a   | armeabi                    | Incompatible with ARMv5/v6 devices.
|               | Thumb-2                    |
|               | VFPv3-D16                  |
| **arm64-v8a** | [AArch64]
| **x86**       | [x86][i386] (IA-32)        | No support for MOVBE or SSE4.
|               | MMX
|               | SSE/2/3
|               | SSSE3
| **x86_64**    | [x86-64][x86_64]
|               | MMX
|               | SSE/2/3
|               | SSSE3
|               | SSE4.1, 4.2
|               | POPCNT

[aarch64]: https://archive.mozilla.org/pub/mobile/releases/68.11.0/android-aarch64/multi/fennec-68.11.0.multi.android-aarch64.apk
[i386]: https://archive.mozilla.org/pub/mobile/releases/68.11.0/android-x86/multi/fennec-68.11.0.multi.android-i386.apk
[x86_64]: https://archive.mozilla.org/pub/mobile/releases/68.11.0/android-x86_64/multi/fennec-68.11.0.multi.android-x86_64.apk
