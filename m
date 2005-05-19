From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1833
Message-Id: <Pine.LNX.4.58.0412021007150.25485@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Further investigation of the X6DVL-EG board (visual inspection
as well as digging through the documentation) indicates that 
the likely SMB controller is the 6300ESB "Hance Rapids" controller.
There is a W83627HF chip on the board as well, which sensors-detect
finds in IO sensors detect.  But it doesn't have any of the interesting
temps attached to it as far as I can tell.

Steve Timm


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
