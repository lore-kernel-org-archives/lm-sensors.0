From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Proposal: doc/examples/chips/motherboards/...
Message-Id: <20011228093951.G5856@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011226224523.A4174@westend.com>
In-Reply-To: <20011226224523.A4174@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Yeah, that's a nobel idea.  We try to support chips (vs. mobos) and
give flexible configurations, but sometimes a 'hint' doc or starter
config for the specific mobo would help. 


Phil


On Wed, Dec 26, 2001 at 10:45:23PM +0100, Christian Hammers wrote:
> Hi
> 
> While browsing the bug tracking system I got the idea that providing
> example files for every known motherboard would not be a bad idea. 
> So a directory structure like:
> 
> 	doc/examples/general-example.conf
> 	doc/examples/via686a/Epox-KT8A.conf
> 	doc/examples/lm75/Asus-XYZ.conf
> 
> would be better. Then, when people are reporting that their motherboard
> swaps CPU and P/S fan speed or does different voltage computations you 
> could easily ask for a file and don't get further complains.
> 
> Telling everybudy to figure out the values himself or read ton's of docs
> to do so is suboptimal.
> 
> bye,
> 
>     -christian-
> 
> -- 
> The end of the human race will be that it will eventually die of
> civilization.
>                 -- Ralph Waldo Emerson

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
