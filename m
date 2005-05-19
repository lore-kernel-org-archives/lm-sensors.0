From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Asus PCH-DR
Message-Id: <425ED53C.1050109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <425E7468.8020500@twilightinc.nl>
In-Reply-To: <425E7468.8020500@twilightinc.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please install lm_sensors package on your system. You can have it from our website.
(Follow different instructions for 2.6 and 2.4 kernels)

When installed please run sensors-detect
It will tell you what chip it found and what modules to load.

Load them and issue sensors command. You can fine tune your configuration by editing /etc/sensors.conf

I hope this helps

Regards

Rudolf
