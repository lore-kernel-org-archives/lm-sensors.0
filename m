From: Rudolf Marek <r.marek@sh.cvut.cz>
Date: Sat, 02 Feb 2008 00:04:24 +0000
Subject: Re: [lm-sensors] Help with readings (k8temp - dme1737)
Message-Id: <47A3B388.6020903@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <479F751E.6080707@gmail.com>
In-Reply-To: <479F751E.6080707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> Which is the true cpu temp ? Core1 from K8temp or CPU temp from dme1737.

DME1737.

> What's the meaning of life? Who knows? No seriously, I can't speak for
> the k8temp but certain CPU types are broken and return bogus temp
> values. You might want to send the output of 'cat /proc/cpuinfo' to
> the list and have Rudolf M. take a look at it.

Yes most notably the new revision G (Brisbane?)

Please can you post here the lspci -xxx
and cat /proc/cpuinfo

Someone suggested that the diode offset readout might correlate with wrong
digital sensor readings. There was some patch that applied diode compensation to
DTS but noone from AMD confirmed that it might work this way.

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
