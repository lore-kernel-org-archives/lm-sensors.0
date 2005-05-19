From: ch@westend.com (Christian Hammers)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Proposal: doc/examples/chips/motherboards/...
Message-Id: <20011226224523.A4174@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

While browsing the bug tracking system I got the idea that providing
example files for every known motherboard would not be a bad idea. 
So a directory structure like:

	doc/examples/general-example.conf
	doc/examples/via686a/Epox-KT8A.conf
	doc/examples/lm75/Asus-XYZ.conf

would be better. Then, when people are reporting that their motherboard
swaps CPU and P/S fan speed or does different voltage computations you 
could easily ask for a file and don't get further complains.

Telling everybudy to figure out the values himself or read ton's of docs
to do so is suboptimal.

bye,

    -christian-

-- 
The end of the human race will be that it will eventually die of
civilization.
                -- Ralph Waldo Emerson
