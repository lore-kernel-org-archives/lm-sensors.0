From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 31 Oct 2005 00:59:37 +0000
Subject: [lm-sensors] SiS630 sensors.conf errors
Message-Id: <20051030235843.GF26397@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Minor bugs, but can be confusing:

  # The following is for the Inside Technologies 786LCD which uses either a
  # IT8705F or a SIS950 for monitoring with the SIS630.
  # You will need to load the it87 module as follows to select the correct
  # temperature sensor type.
  # modprobe it87 temp_type=0x31

Module it87 doesn't have a temp_type option.

The settings for low and high temperature values are missing for all
temperatures.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.
