From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd050322122875ae0992@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for pasting the decoded output twice in the last message.
Here is what gdb shows for nvidia_gpio_setsda.

c020c94d(gdb) x/30i 0xc020c94d
0xc020c94d <nvidia_gpio_setsda+29>:     mov    %dl,0x3d4(%eax)
0xc020c953 <nvidia_gpio_setsda+35>:     mov    0x900(%ebx),%esi
0xc020c959 <nvidia_gpio_setsda+41>:     movzbl 0x3d5(%esi),%eax
0xc020c960 <nvidia_gpio_setsda+48>:     movzbl %al,%eax
0xc020c963 <nvidia_gpio_setsda+51>:     mov    %eax,%edx
0xc020c965 <nvidia_gpio_setsda+53>:     and    $0xe0,%eax
0xc020c96a <nvidia_gpio_setsda+58>:     and    $0xf0,%edx
0xc020c970 <nvidia_gpio_setsda+64>:     or     $0x10,%edx
0xc020c973 <nvidia_gpio_setsda+67>:     cmpl   $0x0,0xc(%ebp)
0xc020c977 <nvidia_gpio_setsda+71>:     cmove  %eax,%edx
0xc020c97a <nvidia_gpio_setsda+74>:     movzbl 0x4(%ecx),%eax
0xc020c97e <nvidia_gpio_setsda+78>:     or     $0x1,%edx
0xc020c981 <nvidia_gpio_setsda+81>:     inc    %eax
0xc020c982 <nvidia_gpio_setsda+82>:     mov    %al,0x3d4(%esi)
0xc020c988 <nvidia_gpio_setsda+88>:     mov    0x900(%ebx),%eax
0xc020c98e <nvidia_gpio_setsda+94>:     mov    %dl,0x3d5(%eax)
0xc020c994 <nvidia_gpio_setsda+100>:    mov    0x4(%esp),%esi
0xc020c998 <nvidia_gpio_setsda+104>:    mov    (%esp),%ebx
0xc020c99b <nvidia_gpio_setsda+107>:    leave
0xc020c99c <nvidia_gpio_setsda+108>:    ret
0xc020c99d <nvidia_gpio_setsda+109>:    lea    0x0(%esi),%esi
0xc020c9a0 <nvidia_gpio_getscl>:        push   %ebp
0xc020c9a1 <nvidia_gpio_getscl+1>:      mov    %esp,%ebp
0xc020c9a3 <nvidia_gpio_getscl+3>:      mov    0x8(%ebp),%eax
0xc020c9a6 <nvidia_gpio_getscl+6>:      mov    (%eax),%ecx
0xc020c9a8 <nvidia_gpio_getscl+8>:      movzbl 0x4(%eax),%edx
0xc020c9ac <nvidia_gpio_getscl+12>:     mov    0x900(%ecx),%eax
0xc020c9b2 <nvidia_gpio_getscl+18>:     mov    %dl,0x3d4(%eax)
0xc020c9b8 <nvidia_gpio_getscl+24>:     mov    0x900(%ecx),%eax
0xc020c9be <nvidia_gpio_getscl+30>:     movzbl 0x3d5(%eax),%edx
