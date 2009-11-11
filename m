From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Nov 2009 16:29:49 +0000
Subject: Re: [lm-sensors] Netroedge legacy server is offline
Message-Id: <20091111172949.5ba8c7f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB503C0-3F14-4ACB-BE74-7DCEA14721C6@edgedesign.us>
In-Reply-To: <3FB503C0-3F14-4ACB-BE74-7DCEA14721C6@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

On Tue, 10 Nov 2009 19:13:19 -0800, Philip Edelbrock wrote:
> We're relocating and trying to consolidate/phase-out some equipment at  
> our company.  One side effect is an old server that hosts some  
> mirrored files as well as some legacy files for Lm_sensors is offline  
> right now.
> 
> If the files aren't easily and quickly relocatable, I might just try  
> to bring that old beast back online until I get some time to do a  
> proper relocation to a better server/service.
> 
> I've put a note on the Lm_sensors wiki download page noting the  
> temporary outage.
> 
> Sorry for the late notice, I only just realized that there was still  
> some Lm_sensors files still being hosted there by FTP.

Thanks for taking care. I'm not totally sure how temporary or permanent
the outage is supposed to be. If it is temporary, I guess we can live
without a mirror for a few days or weeks... at least until the next
lm-sensors release.

If permanent, then we have to look for a different mirror server.
Although this is not necessarily very appealing, I could host the files
myself if needed. This is only 37 MB of data total (34 MB for
lm-sensors and 3 MB for i2c), nothing frightening.

Please let us know.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
