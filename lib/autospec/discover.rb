$:.push(File.join(File.dirname(__FILE__), %w[.. .. spec]))    
  
Autotest.add_discovery do    
  "rspec"   
end