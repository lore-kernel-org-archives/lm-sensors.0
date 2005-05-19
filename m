From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <40566F12.90501@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sent it to Phil a couple of years ago.
Phil?

Mark M. Hoffman wrote:
> Hi Mark:
> 
> IIRC, you have a real sis5595 board.  Could you please try
> this out on it?  W/ kernel 2.6 as well, if you can.
> 
> * author@mordac.netroedge.com <author@mordac.netroedge.com> [2004-03-14 20:23:54 -0800]:
> 
>>Update of /home/cvs/lm_sensors2/prog/detect
>>In directory mordac.netroedge.com:/tmp/cvs-serv28400/prog/detect
>>
>>Modified Files:
>>	sensors-detect 
>>Log Message:
>>(mmh) Added custom detection for some SiS chipsets.  This resolves a long-
>>standing false detection problem.  Other changes in support of this custom
>>detection:
>>
>>1) Changed pci_list to a hash, with keys of the form "1039:0016"
>>2) Added @kernel_version detection and comparison routine (thanks Khali)
>>3) Removed legacy sub: read_proc_pci
> 
> 
> Thanks,
> 

