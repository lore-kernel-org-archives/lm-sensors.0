From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 20 Oct 2005 08:56:50 +0000
Subject: [lm-sensors] lm-sensors in a rollout on FC4 - Attempts fail
Message-Id: <43573FA7.3030205@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4356F706.20904@cosc.canterbury.ac.nz>
In-Reply-To: <4356F706.20904@cosc.canterbury.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Peter Glassenbury wrote:
> Hi all,
> I ran sensor-detect and everything just works - thanks for great utility.
> 
> I would like to roll out this to all our machines (around 250) via
> the kickstart setup that we do. (onto about 5 variations of machine)
> I tried to copy what I though were the config files but seemed to miss
> something because I got no sensors until I ran sensor-detect.
> 
> There are two ways I suppose to fix this...
> 
> ** 1 ** Is there a way to run the sensor-detect without prompts??
> so I can just put it in the kickstart configuration files.

Hi, just quick note, because I gotta go. Did you try something like:

  yes | sensors-detect

Regards
Rudolf
