From: mpiktas@gmail.com (Vaidotas Zemlys)
Date: Thu, 01 Mar 2007 08:57:49 +0000
Subject: [lm-sensors] support for Asus F3Jp laptop
Message-Id: <e47808320703010057r1675adeco893527c3f7c27790@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e47808320702280701i14a0ee20vb4745361c55d09bb@mail.gmail.com>
In-Reply-To: <e47808320702280701i14a0ee20vb4745361c55d09bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 2/28/07, christophe <christophe.dr at free.fr> wrote:
> Le Mercredi 28 F?vrier 2007 23:31, Vaidotas Zemlys a ?crit:
> > [...]
>
> I had the same problem (solved in a thread some weeks ago) with an asus w1n
> laptop. The problem was that smbus was hidden.
> You can check if your smbus is hidden by runing :
> lspci|grep SMBus
>

The output of this command is:
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)

I read the thread you were refering. I downloaded the bash script
provided by Rudolph Marek, but I see that it will not run, because it
does not support ICH7 family. Another question, how did you find out
that you have sensor chip adt7463? Also through lspci? I would like to
find out what chip my laptop has , if it has it at all.

Vaidotas Zemlys

