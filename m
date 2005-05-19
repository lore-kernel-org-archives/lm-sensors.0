From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <408290DD.60109@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I see.
fixed, sorry.
mds

Jean Delvare wrote:
>>unless I'm missing something, there are no more accesses to the bus
>>at that address in scan_adapter() after the detection function
>>returns, so it isn't necessary.
> 
> 
> Wrong. There can be more than one possible chip at a given address. For
> example we detect the MAX6900 at 0x50 after the EEPROMs. After your
> change, I suspect that we actually detect it at 0x30 (where it cannot
> be) instead.
> 
> Even without that, I think we should never rely on the order of the
> entries in @chips_id, nor on the fact that some addresses are used by a
> limited number of chips. These are thing that can change quickly and
> nobody will remember that part of the detection code depended on a
> condition that isn't true anymore.
> 
