From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <20040704225759.GA9425@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 04, 2004 at 09:28:47PM +0200, Rudolf Marek wrote:
> > Tested.
> 
> Thanks
> >
> > So it's working fine for me, isn't it? :)
> seems so :)
> 
> Any ideas how to implement the which_vrm function to lm_sensors ?
> 
> 21:06 < Khali> hmm I don't know exactly
> 21:06 < Khali> there are several options
> 21:07 < Khali> inline function in sensor_vid
> 21:07 < Khali> or regular function in i2c-proc/i2c_sensor
> 21:07 < ruik> which is better ?
> 21:07 < Khali> or new module sensor_vid, replacing the header file
> 21:08 < ruik> its too small to be in module?
> 21:08 < Khali> yes it's a bit small
> 21:08 < Khali> sounds a bit overkill
> 21:08 < Khali> but I'm not sure
> 21:08 < Khali> maybe we should ask other people what they think
> 21:08 < Khali> especially Greg
> 21:09 < Khali> and mds maybe
> 21:09 < ruik> will you :) ?
> 21:09 < Khali> no :p
> 
> So I'm asking :)
> 
> What are your ideas ?

What is your proposal for how to do it?  :)

greg k-h
