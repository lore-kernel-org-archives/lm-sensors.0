From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <Pine.LNX.4.58.0407081559350.18219@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



>
> Hi Rudolf, after loading this module, I now can see voltage and temp.
> statistics, thanks for your support. But now I can see a somewhat strange
> entry:
>
> SYS Temp:  +51.3 C  (high =   +83 C, hyst =   +82 C)
> CPU Temp:  +39.8 C  (high =  +146 C, hyst =   -71 C)

I think just labels are swapped. Please edit /etc/sensors.conf file.

1) find your chip (its name is in sensors output)
2)     label tempX       "Temp2/CPU"
just switch labels or labels definitions(swap temp1 with temp2)
2.5) adjust other options as limits etc
3) run sensors -s to apply changes (needs to be pernement)
4) check if it works :)
>
> PS: I have one entry with "ALARM". What must happen, that such an "ALARM"
> gets displayed?

Not to fit in limits I think after sensors -s they will be programmed.

I hope this helps

regards

Rudolf
