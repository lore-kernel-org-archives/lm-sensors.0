From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Mar 2011 07:10:33 +0000
Subject: Re: [lm-sensors] lm-sensors 3.3.0 has been released!
Message-Id: <20110329091033.5736b939@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110328094824.66a37c40@endymion.delvare>
In-Reply-To: <20110328094824.66a37c40@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

D'oh! I had made the changes to the Download page, but indeed they were
lost. Either I forgot to save them, or the server somehow didn't get
them. Either way, thanks, for stepping in!

On Mon, 28 Mar 2011 19:43:42 -0700, Philip Edelbrock wrote:
> 
> OK, thanks Jean.  I've copied the bundle and sig to the mirror.
> 
> I have also updated the download page (it was still referring to 3.2.0) as best I could, but of course feel free to revise as needed.
> 
> Thanks again, all!  Always interesting to see what new support has been added.
> 
> 
> Phil
> 
> On Mar 28, 2011, at 12:48 AM, Jean Delvare wrote:
> 
> > Hi all,
> > 
> > I just released lm-sensors 3.3.0 as announced ten days ago.
> > This release adds support for intrusion detection and humidity sensors,
> > as well as many new attributes for existing sensor types.
> > 
> > Most important changes are:
> > * Support for intrusion detection sensors.
> > * Support for humidity sensors.
> > * Support for many subfeatures implemented by new hwmon drivers.
> > * Some arbitrary limits removed from libsensors.
> > * New generic limit printing code in "sensors".
> > * New chips known by sensors-detect, as usual.
> > 
> > See CHANGES for the details.
> > 
> > Phil, please copy the new release to your mirror as your time permits.
> > 
> > -- 
> > Jean Delvare
> 
> PHIL EDELBROCK + phil@studiogeologie.com + tel 541 753 4003 + G E O L O G I E + www.studiogeologie.com
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
