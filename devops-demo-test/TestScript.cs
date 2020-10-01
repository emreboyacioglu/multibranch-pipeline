using System;
using Xunit;

namespace devops_demo_test
{
    public class TestScript
    {
        [Fact]
        public void XUnitTest()
        {
            Assert.True(1 == 1);
        }
        [Fact]
        public void XUnitTestOther()
        {
            Assert.True(false);
        }
    }
}
