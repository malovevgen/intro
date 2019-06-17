module Valid
  def valid?
    validate!
    true
  rescue StandartError
    false
  end
end
