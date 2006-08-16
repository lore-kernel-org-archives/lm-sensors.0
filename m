From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 16 Aug 2006 21:04:19 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060816230419.d23f878d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Im not sure which parts bother you most, so I'll break it down as I see it.
> 
> 1.  static decls of ATTRs  intrinsically limits driver to 1 instance, I 
> agree.
> 
> As you note, the chip wouldnt be used 2x on a board, so designing for that
> wasnt valuable (Im guessing).  I dont see the value now in re-doing the 
> driver
> to change this, unless theres something about the migration plan ( that
> has effects, requirements that I dont appreciate yet)

All drivers for Super-I/O chips based on i2c-isa suffer from that
problem. i2c-isa doesn't provide a way to transfer Super-I/O
configuration data up to the device registration function, other than
globals. But once we convert them to platform drivers, things will get
much better and cleaner.

Now I agree that, even then, we probably will never see two Super-I/O
chip on the same board, so that's not really an issue.

> 2.  Previous patch built groups at runtime - thats now gone.
> 
> This patch version declares a separate sub-group for each sensor-type,
> which allows the same runtime-choices, but now creating attr-groups,
> instead of looping thru and creating single attrs.
> As I see it, this copies Marks approach closely.
> 
> patch includes a code-move to bring 3 volts-related attrs and callbacks up
> with the code for VIN, so theyre in-scope for the vin-attr-grp declaration.
> 
> Its had cursory testing, will test over next few days.

Yeah, I like this one much better, however it does change the code,
which isn't OK. Not all chips have 3 fans, and not all chips have 3
temperature sensors. The original code did only create the files for
existing inputs, and I'd like the new code to do the same. It shouldn't
be too difficult, see how Mark did for the w83627hf driver, it looks
nice enough to me. For these entries you'll have to keep registering
them manually, even though you can delete them as a group.

You can probably avoid moving the code around by adding the arrays of
pointers at the end of the attribute declarations.

Thanks,
-- 
Jean Delvare

