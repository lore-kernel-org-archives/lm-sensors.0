From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: still have sensors-detect perl problems
Message-Id: <3F05D475.70300@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(perl 5.005_02)

at beginning:

Useless use of a constant in void context at prog/detect/sensors-detect line 1357.

then dies at:

Can't use string (":raw") as a symbol ref while "strict refs" in use at prog/detect/sensors-detect line 1357, <STDIN> chunk 7.
