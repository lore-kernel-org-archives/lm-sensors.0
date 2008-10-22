From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 07:42:21 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg move some io access from the
Message-Id: <20081022094221.52090369@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FDE62B.7020607@redhat.com>
In-Reply-To: <48FDE62B.7020607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 22 Oct 2008 09:34:41 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Really, you should use quilt. That would solve this problem.
> 
> I hear lots of good things about quilt I'll try to use it next time around.

That's really easy:

$ quilt new hwmon-f71882fg-fix-stuff.patch
$ quilt add drivers/hwmon/f71882fg.c
# Edit the file, build, test, etc.
$ quilt diff		# See your changes
$ quilt refresh		# Write them to the disk
$ quilt head -e		# Describe the patch and add your Signed-off-by

And send patches/hwmon-f71882fg-fix-stuff.patch.

Here's my ~/.quiltrc if you want to see what I consider sane defaults:

QUILT_REFRESH_ARGS="--diffstat --strip-trailing-whitespace"
QUILT_DIFF_ARGS="--color"
QUILT_DIFF_OPTS="-p"
QUILT_NO_DIFF_INDEX=1
EDITOR=nedit

If you need help with quilt, just ask, I'll be happy to help you get up
to speed quickly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
