From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Restore compatibility with 2.4 kernels
Message-Id: <ac921f99050308114133e9eeb4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308142854.GA31643@bode.aurel32.net>
In-Reply-To: <20050308142854.GA31643@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 08 Mar 2005 13:39:17 -0500, David Knierim
<david_knierim@earthlink.net> wrote:
> 
> 
> 
> ---------- Forwarded message ----------
> From: Aurelien Jarno <aurelien@aurel32.net>
> To: sensors@Stimpy.netroedge.com
> Date: Tue, 8 Mar 2005 15:28:54 +0100
> Subject: [PATCH] Restore compatibility with 2.4 kernels
> Hi all,
> 
> For the 2.9.0 release of i2c and lm_sensors, a big work has been done to
> address compatibility problems between 2.4 kernels and i2c/lm-sensors.
> The compatibility was announced as restored, but unfortunately, there is
> still a small difference in one structure defined in i2c.h, namely
> i2c_adapter.
> 
> I have tried to do a patch to fix the latest issues, but I am not sure
> it is correctly done.
> 
> In the kernel version of i2c.h, the client_count variable is present,
> whereas it is not in the i2c one. I have simply added it, as well as the
> code to increment/decrement it.
> 
> Then the complex part is about the semaphores:
> 
> In the kernel a semaphore called lock is used to only allow one i2c
> transfer at once. In i2c, a semaphore is also used for the same job, but
> called bus. The fix was easy, just renaming the variable.
> 
> But there is one more semaphore in i2c, called list, used to lock the
> list of i2c clients. This one is not present in the kernel, as this
> list was not locked in i2c 2.7.0 and previous versions. I supposed it
> has been added due to some race conditions that have been observed, so I
> choosed to use the same semaphore as for i2c transfer to lock the clients
> list. It has the drawback to not allow an i2c transfer while
> adding/removing a client or to not allow adding a new client during an
> i2c transfer. I don't consider that as a problem, as adding/removing a
> client does not happen so often. I have also checked that not i2c
> transfers are asked between too lock of the list.
> 
> I haven't tested my patch (only tested it build correctly), because I am
> not at home, so I can't change easily my 2.6 kernel to a 2.4 one.
> Nevertheless, I would like for people with good knowledge of i2c-core.c
> to tell me if the patch seems ok or not. Thanks.
>
 Hi Aurelien,

I have applied your patch to the 2.9.0 sources, built it, installed it
and ran some tests.
In particular I was still seeing panics when unloading sensors
drivers.   It seems to fix this.
I had sent out a script that loaded and unloaded modules as stress
test, and I ran this, with  another script reading a particular
modules proc entry.   I do not seem to get any panics (though I need
to run this a wee bit longer to be sure).  It actually has an
interesting behavior.  Sometimes it seems to seem to slow down the
loading and unloading of modules (which is fine), and at other times
it will cause the unload to fail with modprobe printing that device or
resource is busy.   This to IMHO  seems to be an OK behavior.

I am hoping to see a very long run, so I can call this panic gone.  I
will let you know.

Cheers...james
