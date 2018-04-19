using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DotnetTest
{
    public partial class Form1 : Form
    {
        TcpClient client = new TcpClient();

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            client.Connect("127.0.0.1", 1007);

            try
            {
                // buffer to read data from socket partially
                byte[] buffer = new byte[client.ReceiveBufferSize];
                NetworkStream readStream = client.GetStream();

                if (readStream.CanRead)
                {
                    StringBuilder completeMessage = new StringBuilder();

                    int numberOfBytesRead = 0;

                    // Incoming message may be larger than the buffer size.
                    do
                    {
                        numberOfBytesRead = readStream.Read(buffer, 0, buffer.Length);

                        completeMessage.AppendFormat("{0}", Encoding.ASCII.GetString(buffer, 0, numberOfBytesRead));
                        listBox1.Items.Add(completeMessage.ToString());
                        completeMessage.Clear();
                        System.Threading.Thread.Sleep(500);
                    }
                    while (readStream.DataAvailable);

                }

                // close connection
                client.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error during connection handling occured: " + ex.Message);
            }

        }
        
    }
}
