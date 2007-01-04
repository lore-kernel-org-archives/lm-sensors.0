From: a@gaydenko.com (Andrew Gaydenko)
Date: Thu, 04 Jan 2007 02:37:30 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <200701040537.30653@goldspace.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Aha, applied. Thanks! - it helped. Now these sensors are visible too:

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +36?C  (high =   +85?C)

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +36?C  (high =   +85?C)

And, sorry, additional questions arised. 

- W83627DHG shows CPU temp about 6-8 grad lower (well, and it is single sensor,
  and I don't understand what does single sensors show :-)) rather coretemp sensors.
  Who is more honest? It is important because ASUS P5B-VM seems to not support
  PWM-regulating, so I have soldered PWM-controller and need to be sure CPU
  temp is acceptable,

- KDE's SysGuard see the only coretemp sensor. Is it SysGuard-related bug?


==== On Wednesday 03 January 2007 04:55, you wrote: ===On 12/27/06, Andrew Gaydenko <a at gaydenko.com> wrote:
> OK, being waiting for answer, I have tried to patch a kernel. Patching
> was OK (except for rejecting in ./Documentation/...). Kernel making gives:
>

You applied one of Rudolph's patches but it was meant to be part of a
set, you missed one of the files.  It's here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018128.html

