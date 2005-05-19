From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040609021700.GA3018@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-06-06 11:48:34 +0200]:
> What about also using the VRM configuration bit to select the correct
> data->vrm upon load for 627thf and 637hf (instead of default)? The code
> could look like:
> 
> 	/* Read VRM & OVT Config only once */
> 	if (w83627thf = data->type || w83637hf = data->type) {
> 		data->vrm_ovt = 
> 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
> 		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
> 	} else {
> 		/* Convert VID to voltage based on default VRM */
> 		data->vrm = DEFAULT_VRM;
> 	}

I like that.  Patch to follow...

> (As a side note, I don't much see the interest of DEFAULT_VRM. Having
> the same default for all chips doesn't make much sense since older chips
> will most likely need VRM8 and newer chips will most likely need VRM9.
> So I'd propose to get rid of that define and let every driver pick
> whatever is relevant.)

Err, why don't we just read the CPU type out of /proc and set the VRM
accordingly during 'sensors -s'... entirely in userspace?

> Maybe it would also make sense to (physically) change this configuration
> bit whenever the user changes VRM versions? We certainly want VID pins
> and in0 reading to refer to the same VRM version.

Why?  The interpretation of the VID pins has nothing to do with that of
in0; I see the in0 calculation mode as just a driver-internal detail.

Also, to force them in sync would require that writing to VRM also updates
the in0 min and max... not impossible of course, just not worth it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
