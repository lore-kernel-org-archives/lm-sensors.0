From: ploujj@gmail.com (Michael P)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <18e5751305032615416cb51b9c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
Thank you for a prompt peply.
I have not been able to test the patch since the patching process is
taking longer than it should for me. I originally used gentoo's
portage to install lm_sensors, and I don't know how to patch the
ebuild (package) yet. On the other hand, I have yet to successfully
compile lm_sensors from source 'manually'.

In the mean time, I decided to give you my lspci info anyways.

Thank you for your time.


On Fri, 25 Mar 2005 22:06:26 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Hi,
> 
> Here is a patch to sensors-detect which should add detection for your
> nForce4 SMBus. Can you please try and report? If it doesn't work, please
> provide the output of lspci -v and lspci -n.
> 
> Thanks,
> --
> Jean Delvare
> 
> 
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspciv
Type: application/octet-stream
Size: 8025 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050326/c4f05c45/lspciv.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspcin
Type: application/octet-stream
Size: 1019 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050326/c4f05c45/lspcin.obj
