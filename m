From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Get rid of assembler code in kernel/i2c-algo-biths.c
Message-Id: <20050310003504.GA4882@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

There is some assembler code in kernel/i2c-algo-biths.c, which prevents
i2c to be built on x86_64 machines. However, it still works on non-x86
machines, as this part of the code is only built on machines that have
rdtscl, ie x86 and x86_64 architectures.

I propose to change it by C code, as in the patch attached. Please note
that I haven't tested it "in live", as I don't have something that uses
this module. However, I have tested it in a simple C program, and I also
tested that i2c still build correctly.

Surprisingly the assembler code produced from the C code by gcc (3.3 in
my case) is always (-O0 to -O3) more efficient than the asm + C code
(see my attached file).

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net


-------------- next part --------------
Index: kernel/i2c-algo-biths.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-algo-biths.c,v
retrieving revision 1.15
diff -u -d -p -r1.15 i2c-algo-biths.c
--- kernel/i2c-algo-biths.c	29 Dec 2004 10:12:48 -0000	1.15
+++ kernel/i2c-algo-biths.c	10 Mar 2005 00:33:56 -0000
@@ -678,13 +678,9 @@ static _HS_ATTR_ void i2c_tsc_set(struct
 
 static _HS_ATTR_ void i2c_tsc_run(struct i2c_algo_biths_data *adap)
 {
-	unsigned long now, loops, xloops;
-	int d0;
-	xloops = adap->xloops; 
-	__asm__("mull %0"
-		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
-	loops = xloops * HZ;
+	unsigned long now, loops;
+	loops = ((long long) adap->xloops * current_cpu_data.loops_per_jiffy) >> 32; 
+	loops *= HZ;
 	do
 	{
 		rep_nop();
-------------- next part --------------
C + ASM with -O0
----------------  
000014a2 <i2c_tsc_run>:
    14a2:       83 ec 10                sub    $0x10,%esp
    14a5:       8b 44 24 14             mov    0x14(%esp),%eax
    14a9:       8b 40 30                mov    0x30(%eax),%eax
    14ac:       89 44 24 04             mov    %eax,0x4(%esp)
    14b0:       8b 44 24 04             mov    0x4(%esp),%eax
    14b4:       8b 15 84 00 00 00       mov    0x84,%edx
    14ba:       f7 e2                   mul    %edx
    14bc:       89 c1                   mov    %eax,%ecx
    14be:       89 d0                   mov    %edx,%eax
    14c0:       89 44 24 04             mov    %eax,0x4(%esp)
    14c4:       89 c8                   mov    %ecx,%eax
    14c6:       89 04 24                mov    %eax,(%esp)
    14c9:       8b 54 24 04             mov    0x4(%esp),%edx
    14cd:       89 d0                   mov    %edx,%eax
    14cf:       c1 e0 02                shl    $0x2,%eax
    14d2:       01 d0                   add    %edx,%eax
    14d4:       8d 14 85 00 00 00 00    lea    0x0(,%eax,4),%edx
    14db:       01 d0                   add    %edx,%eax
    14dd:       c1 e0 02                shl    $0x2,%eax
    14e0:       89 44 24 08             mov    %eax,0x8(%esp)
    14e4:       f3 90                   pause
    14e6:       0f 31                   rdtsc
    14e8:       89 44 24 0c             mov    %eax,0xc(%esp)
    14ec:       8b 44 24 14             mov    0x14(%esp),%eax
    14f0:       8b 50 2c                mov    0x2c(%eax),%edx
    14f3:       8b 44 24 0c             mov    0xc(%esp),%eax
    14f7:       29 d0                   sub    %edx,%eax
    14f9:       3b 44 24 08             cmp    0x8(%esp),%eax
    14fd:       72 e5                   jb     14e4 <i2c_tsc_run+0x42>
    14ff:       83 c4 10                add    $0x10,%esp
    1502:       c3                      ret
 
 
C only with -O0
--------------- 
 000014a2 <i2c_tsc_run>:
    14a2:       83 ec 08                sub    $0x8,%esp
    14a5:       8b 54 24 0c             mov    0xc(%esp),%edx
    14a9:       a1 84 00 00 00          mov    0x84,%eax
    14ae:       f7 62 30                mull   0x30(%edx)
    14b1:       89 d0                   mov    %edx,%eax
    14b3:       89 c2                   mov    %eax,%edx
    14b5:       c1 fa 1f                sar    $0x1f,%edx
    14b8:       89 04 24                mov    %eax,(%esp)
    14bb:       8b 14 24                mov    (%esp),%edx
    14be:       89 d0                   mov    %edx,%eax
    14c0:       c1 e0 02                shl    $0x2,%eax
    14c3:       01 d0                   add    %edx,%eax
    14c5:       8d 14 85 00 00 00 00    lea    0x0(,%eax,4),%edx
    14cc:       01 d0                   add    %edx,%eax
    14ce:       c1 e0 02                shl    $0x2,%eax
    14d1:       89 04 24                mov    %eax,(%esp)
    14d4:       f3 90                   pause
    14d6:       0f 31                   rdtsc
    14d8:       89 44 24 04             mov    %eax,0x4(%esp)
    14dc:       8b 44 24 0c             mov    0xc(%esp),%eax
    14e0:       8b 50 2c                mov    0x2c(%eax),%edx
    14e3:       8b 44 24 04             mov    0x4(%esp),%eax
    14e7:       29 d0                   sub    %edx,%eax
    14e9:       3b 04 24                cmp    (%esp),%eax
    14ec:       72 e6                   jb     14d4 <i2c_tsc_run+0x32>
    14ee:       83 c4 08                add    $0x8,%esp
    14f1:       c3                      ret

    
C + ASM with -O2
----------------
00000f10 <i2c_tsc_run>:
     f10:       56                      push   %esi
     f11:       8b 35 84 00 00 00       mov    0x84,%esi
     f17:       53                      push   %ebx
     f18:       8b 5c 24 0c             mov    0xc(%esp),%ebx
     f1c:       89 f2                   mov    %esi,%edx
     f1e:       8b 4b 30                mov    0x30(%ebx),%ecx
     f21:       89 c8                   mov    %ecx,%eax
     f23:       f7 e2                   mul    %edx
     f25:       8d 04 92                lea    (%edx,%edx,4),%eax
     f28:       8d 04 80                lea    (%eax,%eax,4),%eax
     f2b:       8d 0c 85 00 00 00 00    lea    0x0(,%eax,4),%ecx
     f32:       8d b4 26 00 00 00 00    lea    0x0(%esi),%esi
     f39:       8d bc 27 00 00 00 00    lea    0x0(%edi),%edi
     f40:       f3 90                   pause
     f42:       0f 31                   rdtsc
     f44:       8b 73 2c                mov    0x2c(%ebx),%esi
     f47:       29 f0                   sub    %esi,%eax
     f49:       39 c8                   cmp    %ecx,%eax
     f4b:       72 f3                   jb     f40 <i2c_tsc_run+0x30>
     f4d:       5b                      pop    %ebx
     f4e:       5e                      pop    %esi
     f4f:       c3                      ret


C only with -O2
---------------
00000f10 <i2c_tsc_run>:
     f10:       53                      push   %ebx
     f11:       a1 84 00 00 00          mov    0x84,%eax
     f16:       8b 5c 24 08             mov    0x8(%esp),%ebx
     f1a:       f7 63 30                mull   0x30(%ebx)
     f1d:       8d 04 92                lea    (%edx,%edx,4),%eax
     f20:       8d 04 80                lea    (%eax,%eax,4),%eax
     f23:       8d 0c 85 00 00 00 00    lea    0x0(,%eax,4),%ecx
     f2a:       8d b6 00 00 00 00       lea    0x0(%esi),%esi
     f30:       f3 90                   pause
     f32:       0f 31                   rdtsc
     f34:       8b 53 2c                mov    0x2c(%ebx),%edx
     f37:       29 d0                   sub    %edx,%eax
     f39:       39 c8                   cmp    %ecx,%eax
     f3b:       72 f3                   jb     f30 <i2c_tsc_run+0x20>
     f3d:       5b                      pop    %ebx
     f3e:       c3                      ret
     f3f:       90                      nop
