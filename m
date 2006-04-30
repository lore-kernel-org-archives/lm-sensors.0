From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sun, 30 Apr 2006 19:15:59 +0000
Subject: [lm-sensors] sensors work but broke the network and sound
Message-Id: <4dfa50520604301215t610641f8o531a6484c64abc80@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060430120557.12F6E18C67F@mail.host.bg>
In-Reply-To: <20060430120557.12F6E18C67F@mail.host.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kamen,

First of all, can you undo the changes and get the sound card and
network card working again? We'll need to go step by step to find out
what point exactly it is that breaks everything.

Then, paste the following things into your email.
1. Output of sensors-detect
2. /etc/modules.conf and what changes you are making
3. /etc/rc.d/rc.modules and the changes you are making
4. What kernel version you have
5. What distribution you are running

David

On 4/30/06, kamen <kamen at ggbit.info> wrote:
> Hi
>
> I configured the sensors, now they're working great, but I haven't got network and sound !!!! My sound card is realtek ac97 and the ethernet card is Intel 3Com. I didn't do anything different from typing sensors-detect and then editing /etc/modules.conf and /etc/rc.d/rc.modules as shown in the examples ! Have you got any suggestions how could I repair it ?? Please help!

