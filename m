From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: call for 2.6.5 soon
Message-Id: <3D518F59.F0E33526@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D3CBBA1.B4B210B0@paradyne.com>
In-Reply-To: <3D3CBBA1.B4B210B0@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> 
> > I've finished the dmi_scan module and also copied the dmidecode
> > program to prog/detect. And I added it to the install target so it
> > would be available to sensors-detect.
> A good idea indeed.
> 
> > At this point the easiest thing to do in sensors detect may be
> > to do (please translate this mess to perl)
> > system(dmidecode) | "some code that will grep for 'System Information
> > Block\n\t\tVendor: IBM'"
> Sounds insecure to me, but I wouldn't be considered paranoid. I am not
> sure we should accept relying on an external program for something of
> such importance. Some future changes to dmidecode could have disastrous
> consequences, not even talking about malicious coders using this
> weakness with some odd intentions. Maybe it is possible to make it
> secure enough for most could-possibly-happen cases.
> 

Well, that's why I thought it would be good to put dmidecode in our package,
so we could both use it and control it, and modify it if we want if
that would be easier then putting it all in perl inside sensors-detect. 
I had no idea there were multiple versions of it out there.
I folded in the sensors prints into it in about an hour, didn't think
too hard about it.

Your patch/merge plan sounds fine to me.
Where is the version you refer to as the "official" one in "Alan's files"?

> Anyway, I had a look at dmidecode by Alan. I read and understood
> everything it does, and I think it wouldn't be that hard to do the same
> directly in Perl. It would of course need more time than for the
> system() thing suggested above. Really depends wether we prefer (secure
> + efficient) or (quick + no code duplication). I personally opt for the
> first, but am open to any opinion. A solution may be to be quick at
> first, and back to the secure way later. Depends on the deadline we
> have, if we have one?


Well I think we want to release after we have at least 3 of these things done:

- IBM detection in i2c-piix4 (done)
- IBM detection in sensors-detect
- 24RF08 experiments by Joe in Australia (I pinged him again recently)
- 24RF08 experiments by MDS (doubtful I will get samples)

Hopefully in a week or two...
