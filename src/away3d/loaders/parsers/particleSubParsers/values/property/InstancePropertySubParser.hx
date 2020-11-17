package away3d.loaders.parsers.particleSubParsers.values.property;

import away3d.loaders.parsers.particleSubParsers.AllIdentifiers;
import away3d.loaders.parsers.particleSubParsers.values.ValueSubParserBase;
import away3d.loaders.parsers.particleSubParsers.values.oneD.OneDConstValueSubParser;
import away3d.loaders.parsers.particleSubParsers.values.setters.SetterBase;
import away3d.loaders.parsers.particleSubParsers.values.setters.property.InstancePropertySubSetter;
import away3d.loaders.parsers.particleSubParsers.values.threeD.ThreeDConstValueSubParser;

class InstancePropertySubParser extends ValueSubParserBase {
	public static var identifier(get, never):Dynamic;

	private var _positionValue:ThreeDConstValueSubParser;
	private var _rotationValue:ThreeDConstValueSubParser;
	private var _scaleValue:ThreeDConstValueSubParser;
	private var _timeOffsetValue:OneDConstValueSubParser;
	private var _playSpeedValue:OneDConstValueSubParser;

	public function new(propName:String) {
		super(propName, ValueSubParserBase.CONST_VALUE);
	}

	override private function proceedParsing():Bool {
		if (_isFirstParsing) {
			if (_data.position != null) {
				_positionValue = new ThreeDConstValueSubParser(null);
				addSubParser(_positionValue);
				_positionValue.parseAsync(_data.position.data);
			}
			if (_data.rotation != null) {
				_rotationValue = new ThreeDConstValueSubParser(null);
				addSubParser(_rotationValue);
				_rotationValue.parseAsync(_data.rotation.data);
			}
			if (_data.scale != null) {
				_scaleValue = new ThreeDConstValueSubParser(null);
				addSubParser(_scaleValue);
				_scaleValue.parseAsync(_data.scale.data);
			}
			if (_data.timeOffset != null) {
				_timeOffsetValue = new OneDConstValueSubParser(null);
				addSubParser(_timeOffsetValue);
				_timeOffsetValue.parseAsync(_data.timeOffset.data);
			}
			if (_data.playSpeed != null) {
				_playSpeedValue = new OneDConstValueSubParser(null);
				addSubParser(_playSpeedValue);
				_playSpeedValue.parseAsync(_data.playSpeed.data);
			}
		}

		if (super.proceedParsing() == ParserBase.PARSING_DONE) {
			initSetter();
			return ParserBase.PARSING_DONE;
		} else {
			return ParserBase.MORE_TO_PARSE;
		}
	}

	private function initSetter():Void {
		var positionSetter:SetterBase = (_positionValue != null) ? _positionValue.setter : null;
		var rotationSetter:SetterBase = (_rotationValue != null) ? _rotationValue.setter : null;
		var scaleSetter:SetterBase = (_scaleValue != null) ? _scaleValue.setter : null;
		var timeOffsetSetter:SetterBase = (_timeOffsetValue != null) ? _timeOffsetValue.setter : null;
		var playSpeedSetter:SetterBase = (_playSpeedValue != null) ? _playSpeedValue.setter : null;
		_setter = new InstancePropertySubSetter(_propName, positionSetter, rotationSetter, scaleSetter, timeOffsetSetter, playSpeedSetter);
	}

	private static function get_identifier():Dynamic {
		return AllIdentifiers.InstancePropertySubParser;
	}
}
