From: jordan.crouse@amd.com (Jordan Crouse)
Date: Tue, 02 May 2006 15:37:46 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060502153746.GK22167@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/05/06 12:10 +0200, Thomas Andrews wrote:
> Hi Jordan,
> 
> What am I missing here ?
> 
> I can get my Atmel chip to generate a packet as a master, and the geode
> actually does ACK the address, so the geode is definitely behaving
> correctly as a slave. Somehow the interrupt just never happens though.

Try turning on the general match bit, and see if that causes the interrupt
to fire.  

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


