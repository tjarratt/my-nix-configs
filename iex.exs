defmodule Aphorisms do
  def one() do
    {aphorism, 0} = System.cmd("cowsay", random_message())
 
    aphorism 
  end

  defp random_messages() do
    [
      "Dreams are messages from the deep.",
      # 
      "You crazy for this one Rick ! It's your boy !",
      #
      "Heavy is the head that wears the crown.",
      "As above, so below.",
      # 
      "Assigning responsibility lacks integrity",
      "Accepted responsibility is the foundation of integrity",
      #
      "This is the part of the animal we don't eat.",
      "We use every part of the buffalo.",
      "The reason software keeps changing is because everything is changing.",
      #
      "First, make the change easy (warning : this is hard), then make the easy change.",
      "Big changes are an illusion. ALl changes are small. There are only longer and shorter feedback cycles.",
      #
      "Do the right thing",
      "Do what works",
      "Be kind"
    ]
    |> Enum.random()
    |> String.split()
  end
end

IO.ANSI.white()
|> Kernel.<>(Aphorisms.one())
|> Kernel.<>(IO.ANSI.reset())
|> Kernel.<>(IO.ANSI.blink_slow())
|> IO.puts()

