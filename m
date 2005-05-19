From: ilia.stolov@nsc.com (Ilia Stolov)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: PC87431 is not - need full datasheet.
Message-Id: <loom.20050104T131315-886@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D72B.2040706@ocesb.com.my>
In-Reply-To: <41D5D72B.2040706@ocesb.com.my>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Mark Studebaker <mds4 <at> verizon.net> writes:

> 
> ask National Semiconductor.
> 
> Chan Min Wai (System Administrator) wrote:
> > Hello all,
> > 
> > I'm on Ticket #1853
> > 
> > Is there anyway I can help to obtain a full data sheet?
> > What kind of full data sheet do you need?
> > 
> > What should be included?
> > 
> > I would like to help in this, I've contact Intel Support and I think
> > they will help in somewhere. So please tell me what do you really want
> > and I'll try my best to get that. However I'll have no promise about
> > what I can get, but I'll try my very best on this issue.
> > 
> > 
> >>ADM1026 is supported.
> >>PC87431 is not - need full datasheet.
> >>These are both listed on our new drivers and supported chips pages for your
> >>information.
> >>If ADM1026 is not found, perhaps the SMBus master is not supported.
> >>See FAQ.
> >>
> >>MDS 12/31/04
> > 
> > 
> > Regards
> > 
> > Chan Min Wai
> > 
> > 
> 

Following by recently requests about National's PC87431 mBMC device, 
please find the following information:
1. The PC87431 is fully IPMI 1.5 compliant device with remote 
   LAN manageability support
2. The Host interface of PC87431 is IPMI 1.5/2.0 SSIF (SMBus)
3. The PC87431 supports all mandatory commands of IPMI 1.5
4. System configuration and sensor list can be read using regular IPMI 
   SDR commands
5. Specific sensor data can be obtained using IPMI "Get Sensor Reading" 
   command

More information about PC87431 can be found on:
http://www.national.com/pf/PC/PC87431M.html

The full PC87431 datasheet can be obtained under NDA.

For more information about IPMI specification, please see IPMI developers 
web-site:
http://developer.intel.com/design/servers/ipmi/index.htm

Attached are sample sources of SSIF interface implementation for PC87431.
Sources provided under BSD license agreement.

> 



